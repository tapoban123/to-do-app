import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context, {
  required String titleText,
  required String contentText,
  required IconData icon,
  String actionButtonText = "Try again",
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      icon: CircleAvatar(
        backgroundColor: Colors.redAccent[700],
        radius: 40,
        child: Text(
          String.fromCharCode(icon.codePoint),
          style: TextStyle(
            inherit: false,
            fontSize: 60,
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(
        titleText,
        style: TextStyle(fontSize: 30),
      ),
      content: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              contentText,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[400],
                minimumSize: Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                actionButtonText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
