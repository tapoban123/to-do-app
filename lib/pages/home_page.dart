import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_snackbar.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/core/model/task_model.dart';

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
  void initState() {
    LocalNotificationsService().cancelActiveNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Consumer<PendingTasksDbServices>(
        builder: (context, pendingTasksProvider, child) {
          if (pendingTasksProvider.getAllTasks.isEmpty) {
            if (firstRun) {
              pendingTasksProvider.storePreviousData();
              firstRun = false;
            }

            return NoTasksScreen(
              buttonColor: Colors.purple[700]!,
              buttonText: "Create a task now",
              onButtonTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CreateTaskPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final tween = Tween(
                      begin: Offset(1, 0),
                      end: Offset.zero,
                    ).chain(
                      CurveTween(curve: Curves.linearToEaseOut),
                    );

                    final animationOffset = animation.drive(tween);
                    return SlideTransition(
                      position: animationOffset,
                      child: child,
                    );
                  },
                ));
              },
              pageContentText: "You do not have any pending tasks right now.",
            );
          }
          return Column(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  scrollController: widget.scrollDirection,
                  scrollDirection: Axis.vertical,
                  itemCount: pendingTasksProvider.getAllTasks.length,
                  onReorder: (int oldIndex, int newIndex) {
                    pendingTasksProvider.reOrderTasks(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    );
                  },
                  itemBuilder: (context, index) {
                    final eachTask = pendingTasksProvider.getAllTasks[index];
                    checkBoxValues.add(false);

                    return Padding(
                      key: ValueKey(index),
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        leading: Icon(Icons.drag_handle_rounded),
                        title: Text(
                          eachTask.taskTitle,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: Theme.of(context).hintColor),
                        ),
                        subtitle: eachTask.taskDescription.isEmpty
                            ? null
                            : Text(
                                eachTask.taskDescription,
                                overflow: TextOverflow.ellipsis,
                              ),
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      CreateTaskPage(
                                oldTask: eachTask,
                                editSpecificTask: true,
                                taskIndex: index,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final tween = Tween(
                                  begin: Offset(0, 1),
                                  end: Offset.zero,
                                ).chain(
                                  CurveTween(
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  ),
                                );

                                final animationOffset = animation.drive(tween);

                                return SlideTransition(
                                  position: animationOffset,
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 500),
                            ),
                          );
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
                              checkColor: Colors.black,
                              activeColor: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onChanged: (value) async {
                                setState(() {
                                  checkBoxValues[index] =
                                      !checkBoxValues[index];
                                });
                                showSnackBar(
                                  context,
                                  "\u{1F600} Yay! You just completed a task.",
                                  Colors.deepPurpleAccent,
                                );

                                await Future.delayed(
                                  Duration(milliseconds: 300),
                                );

                                TaskModel completedTask = TaskModel(
                                  taskId: eachTask.taskId,
                                  taskTitle: eachTask.taskTitle,
                                  taskDescription: eachTask.taskDescription,
                                  isImportant: false,
                                  remindMe: false,
                                  creationDate: eachTask.creationDate,
                                  creationTime: eachTask.creationTime,
                                );
                                LocalNotificationsService()
                                    .cancelSpecificNotification(
                                        completedTask.taskId);

                                Provider.of<CompletedTasksDbServices>(
                                  context,
                                  listen: false,
                                ).addTask(completedTask);

                                checkBoxValues.removeAt(index);

                                pendingTasksProvider.deleteSpecificTask(index);
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
    );
  }
}
