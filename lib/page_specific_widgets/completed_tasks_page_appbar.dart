import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            Provider.of<CompletedTasksDbServices>(context, listen: false)
                .deleteAllCompletedTasks();
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
