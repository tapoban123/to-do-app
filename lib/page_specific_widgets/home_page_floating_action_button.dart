import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';

class HomePageFloatingActionButton extends StatelessWidget {
  const HomePageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CreateTaskPage(),
        ));
      },
      child: const Icon(CupertinoIcons.add),
    );
  }
}
