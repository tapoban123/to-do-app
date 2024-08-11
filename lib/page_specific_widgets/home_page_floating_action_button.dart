import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';

class HomePageFloatingActionButton extends StatelessWidget {
  const HomePageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.none,
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CreateTaskPage(),
        ));
      },
      child: Text(
        String.fromCharCode(CupertinoIcons.add.codePoint),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: CupertinoIcons.add.fontFamily,
          package: CupertinoIcons.add.fontPackage,
          fontSize: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}

// const Icon(
//         CupertinoIcons.add,
//         color: Colors.white,
//       ),
