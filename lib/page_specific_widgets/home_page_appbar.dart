import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/common/show_error_popUps.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/hive_database/pending_tasks_db_services.dart';

class HomePageAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomePageAppbar({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("My Tasks"),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            LocalNotificationsService()
                .showInstantNotificationAndroid("Testing ", "Hello World");
            // showErrorDialog(
            //   context,
            //   icon: Icons.close,
            //   titleText: "Oops!!!",
            //   contentText:
            //       "Failed to create a new task. Please select the date/time in the future.",
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
    );
  }
}
