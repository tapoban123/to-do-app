import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';

class HomePageFloatingActionButton extends StatelessWidget {
  const HomePageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0052D4),
            Color(0xff4364F7),
            Color(0xff6FB1FC),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        clipBehavior: Clip.none,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CreateTaskPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween = Tween(
                  begin: Offset(1, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.fastEaseInToSlowEaseOut),
                );

                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
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
      ),
    );
  }
}
