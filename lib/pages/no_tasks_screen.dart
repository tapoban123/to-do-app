import 'package:flutter/material.dart';
import 'completed_tasks_page.dart';
import 'home_page.dart';

/// The [NoTasksScreen] is displayed when `no tasks are found` on [CompletedTasksPage] or [HomePage].
class NoTasksScreen extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String buttonText;
  final List<Color> gradientColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final String pageContentText;

  const NoTasksScreen({
    super.key,
    required this.buttonText,
    required this.gradientColors,
    required this.gradientBegin,
    required this.gradientEnd,
    required this.onButtonTap,
    required this.pageContentText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              pageContentText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: gradientColors,
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1.0,
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.transparent,
              ),
              onPressed: onButtonTap,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
