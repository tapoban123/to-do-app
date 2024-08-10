import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';

class NoTasksScreen extends StatelessWidget {
  const NoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No tasks present"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateTaskPage(),
              ));
            },
            child: const Text("Create a task now"),
          )
        ],
      ),
    );
  }
}
