import 'package:flutter/material.dart';

void showConfirmationDialog({
  required BuildContext context,
  required IconData icon,
  required String titleText,
  required String contentText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      ButtonStyle _textButtonStyle(Color buttonColor) => TextButton.styleFrom(
            backgroundColor: buttonColor,
            minimumSize: Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          );
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        icon: CircleAvatar(
          backgroundColor: Colors.blueAccent[400],
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: _textButtonStyle(Colors.red.shade400),
                onPressed: onConfirm,
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                style: _textButtonStyle(Colors.blue[400]!),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
