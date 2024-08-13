import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_dialog.dart';
import 'package:simple_todo_app/core/common/show_error_popUps.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';

class HomePageAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomePageAppbar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "PENDING TASKS",
        // style: TextStyle(
        //   fontFamily: "OpenSans",
        //   letterSpacing: 3,
        //   color: Colors.white,
        //   fontWeight: FontWeight.w900,
        // ),
      ),
      centerTitle: true,
      actions: [
        // TextButton(
        //   onPressed: () {
        //     showSnackBar(context, "Task Created", Colors.purple[300]!);
        //   },
        //   child: Icon(Icons.notifications),
        // ),
        TextButton(
          onPressed: () {
            int pendingTasksLength =
                Provider.of<PendingTasksDbServices>(context, listen: false)
                    .getCurrentTaskIndex;
            if (pendingTasksLength != 0) {
              showConfirmationDialog(
                context: context,
                icon: Icons.question_mark,
                titleText: "Are you sure?",
                contentText:
                    "You are about to delete all your pending tasks. Are you sure you want to continue?",
                onConfirm: () {
                  Provider.of<PendingTasksDbServices>(context, listen: false)
                      .deleteDatabase();
                  Navigator.of(context).pop();
                },
              );
            } else {
              showErrorDialog(context,
                  titleText: "No Pending Tasks",
                  contentText:
                      "You currently do not have any pending tasks to delete.",
                  icon: CupertinoIcons.exclamationmark,
                  actionButtonText: "Add new task");
            }
          },
          child: const Icon(
            Icons.delete_sweep,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
