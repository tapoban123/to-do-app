import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_todo_app/core/widgets/important_task_icon.dart';
import 'package:simple_todo_app/core/widgets/scheduled_task_icon.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';
import 'package:simple_todo_app/pages/no_tasks_screen.dart';

class HomePage extends StatefulWidget {
  final ScrollController scrollDirection;

  const HomePage({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstRun = true;
  bool fABIsVisible = true;

  List<bool> checkBoxValues = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                    controller: widget.scrollDirection,
                    scrollDirection: Axis.vertical,
                    itemCount: tasksProvider.getAllTasks.length,
                    itemBuilder: (context, index) {
                      final eachTask = tasksProvider.getAllTasks[index];
                      checkBoxValues.add(false);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ListTile(
                          splashColor: Colors.transparent,
                          leading: Icon(Icons.pending_actions_sharp),
                          title: Text(eachTask.taskTitle),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side:
                                BorderSide(color: Theme.of(context).hintColor),
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
                                      triggerMode: TooltipTriggerMode.longPress,
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
                                      triggerMode: TooltipTriggerMode.longPress,
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
    );
  }
}
