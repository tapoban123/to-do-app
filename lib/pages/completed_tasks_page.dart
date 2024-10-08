import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_snackbar.dart';
import 'package:simple_todo_app/core/providers/navigation_provider.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';
import 'package:simple_todo_app/pages/no_tasks_screen.dart';

class CompletedTasksPage extends StatefulWidget {
  /// Implements the page for displaying all the tasks that have `already been completed by the user`.
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  bool firstRun = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Consumer<CompletedTasksDbServices>(
          builder: (context, completedTasksProvider, child) {
            if (completedTasksProvider.allCompletedTasks.isEmpty) {
              if (firstRun) {
                completedTasksProvider.getAllCompletedTasks();
                firstRun = false;
              }
              return NoTasksScreen(
                gradientBegin: Alignment.topLeft,
                gradientEnd: Alignment.bottomRight,
                gradientColors: [
                  Color(0xff5803dc),
                  Color(0xffe41eff),
                ],
                buttonText: "Complete a task now",
                onButtonTap: () =>
                    Provider.of<NavigationProvider>(context, listen: false)
                        .navigateToPage(0),
                pageContentText: "You have not completed any tasks yet.",
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                itemCount: completedTasksProvider.allCompletedTasks.length,
                itemBuilder: (context, index) {
                  final eachTask =
                      completedTasksProvider.allCompletedTasks[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ).copyWith(top: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            eachTask.taskTitle,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 2,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              "assets/images/double_check_mark.png",
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .color,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                tooltip: "Re-assign task",
                                onPressed: () {
                                  Provider.of<PendingTasksDbServices>(
                                    context,
                                    listen: false,
                                  ).addTask(newTask: eachTask);

                                  completedTasksProvider
                                      .deleteSpecificTask(index);
                                  showSnackBar(
                                    context,
                                    "Re-assigned task successfully.",
                                    Colors.blueAccent,
                                  );
                                },
                                icon: Icon(
                                  Icons.restore_rounded,
                                  color: Colors.blue[400],
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                tooltip: "Delete permanently",
                                onPressed: () {
                                  completedTasksProvider
                                      .deleteSpecificTask(index);
                                  showSnackBar(
                                    context,
                                    "Deleted task successfully.",
                                    Colors.red[400]!,
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red[400],
                                  size: 28,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ))
      ],
    );
  }
}
