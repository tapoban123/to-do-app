import 'package:flutter/material.dart';

class NoTasksScreen extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String buttonText;
  final Color buttonColor;
  final String pageContentText;

  const NoTasksScreen({
    super.key,
    required this.buttonText,
    required this.buttonColor,
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
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: buttonColor,
            ),
            onPressed: onButtonTap,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
