import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_dialog.dart';
import 'package:simple_todo_app/core/common/show_error_popUps.dart';
import 'package:simple_todo_app/core/common/show_snackbar.dart';
import 'package:simple_todo_app/hive_database/completed_tasks_db_services.dart';

class CompletedTasksPageAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  CompletedTasksPageAppbar({super.key})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Completed Tasks"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            if (Provider.of<CompletedTasksDbServices>(context, listen: false)
                .allCompletedTasks
                .isNotEmpty) {
              showConfirmationDialog(
                context: context,
                icon: Icons.question_mark,
                titleText: "Are you sure?",
                contentText:
                    "You are about to delete all your completed tasks. Are you sure you want to continue?",
                onConfirm: () {
                  Provider.of<CompletedTasksDbServices>(context, listen: false)
                      .deleteAllCompletedTasks();
                  showSnackBar(
                    context,
                    "Deleted all completed tasks",
                    Colors.red.shade400,
                  );
                  Navigator.of(context).pop();
                },
              );
            } else {
              showErrorDialog(context,
                  titleText: "No Completed Tasks",
                  contentText: "You do not have any completed tasks yet.",
                  icon: CupertinoIcons.exclamationmark,
                  actionButtonText: "Complete Tasks");
            }
          },
          icon: Icon(
            Icons.delete_sweep_rounded,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
