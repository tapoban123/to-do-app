import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_error_popUps.dart';

import 'package:simple_todo_app/core/widgets/home_page_drawer.dart';
import 'package:simple_todo_app/core/widgets/important_task_icon.dart';
import 'package:simple_todo_app/core/widgets/scheduled_task_icon.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';
import 'package:simple_todo_app/pages/no_tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollViewController = ScrollController();

  bool firstRun = true;
  bool fABIsVisible = true;

  List<bool> checkBoxValues = [];

  @override
  void initState() {
    _scrollViewController.addListener(
      () {
        final scrollDirection =
            _scrollViewController.position.userScrollDirection;
        if (scrollDirection == ScrollDirection.reverse) {
          setState(() {
            fABIsVisible = false;
          });
        } else if (scrollDirection == ScrollDirection.forward) {
          setState(() {
            fABIsVisible = true;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)?.settings.name);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     RootScaffold.openDrawer(context);
          //   },
          //   icon: Icon(Icons.menu_rounded),
          // ),
          title: const Text("My Tasks"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamed("/createTasksPage");
                showErrorDialog(
                  context,
                  icon: Icons.close,
                  titleText: "Oops!!!",
                  contentText:
                      "Failed to create a new task. Please select the date/time in the future.",
                );
                // LocalNotificationsService().showInstantNotificationAndroid(
                //   "Test Notification",
                //   "Testing",
                // );
              },
              child: Icon(Icons.notifications),
            ),
            TextButton(
              onPressed: () {
                Provider.of<PendingTasksDbServices>(context, listen: false)
                    .deleteDatabase();
              },
              child: const Icon(
                Icons.delete_sweep,
                color: Colors.red,
              ),
            )
          ],
        ),

        // drawer: RootScaffold.openDrawer(context),
        drawer: const HomePageDrawer(),
        floatingActionButton: fABIsVisible
            ? FloatingActionButton(
              clipBehavior: Clip.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateTaskPage(),
                  ));
                },
                child: const Icon(CupertinoIcons.add),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Consumer<PendingTasksDbServices>(
            builder: (context, tasksProvider, child) {
              if (tasksProvider.getAllTasks.isEmpty) {
                if (firstRun) {
                  tasksProvider.storePreviousData();
                  firstRun = false;
                }

                return const NoTasksScreen();
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollViewController,
                      scrollDirection: Axis.vertical,
                      itemCount: tasksProvider.getAllTasks.length,
                      itemBuilder: (context, index) {
                        final eachTask = tasksProvider.getAllTasks[index];
                        checkBoxValues.add(false);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            leading: Icon(Icons.pending_actions_sharp),
                            title: Text(eachTask.taskTitle),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                  color: Theme.of(context).hintColor),
                            ),
                            subtitle: eachTask.taskDescription.isEmpty
                                ? null
                                : Text(
                                    eachTask.taskDescription,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateTaskPage(
                                  oldTask: eachTask,
                                  editSpecificTask: true,
                                  taskIndex: index,
                                ),
                              ));
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                eachTask.remindMe
                                    ? Tooltip(
                                        triggerMode:
                                            TooltipTriggerMode.longPress,
                                        child: ScheduledTaskIcon(),
                                        message: "Scheduled Task",
                                      )
                                    : SizedBox.shrink(),
                                (eachTask.isImportant && eachTask.remindMe)
                                    ? SizedBox(
                                        width: 10,
                                      )
                                    : SizedBox.shrink(),
                                eachTask.isImportant
                                    ? Tooltip(
                                        triggerMode:
                                            TooltipTriggerMode.longPress,
                                        child: ImportantTaskIcon(),
                                        message: "Important Task",
                                      )
                                    : SizedBox.shrink(),
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onChanged: (value) async {
                                    setState(() {
                                      checkBoxValues[index] =
                                          !checkBoxValues[index];
                                    });

                                    await Future.delayed(
                                      Duration(milliseconds: 300),
                                    );

                                    Provider.of<CompletedTasksDbServices>(
                                      context,
                                      listen: false,
                                    ).addTask(eachTask);
                                    checkBoxValues.removeAt(index);
                                    tasksProvider.deleteSpecificTask(index);
                                  },
                                  value: checkBoxValues[index],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
