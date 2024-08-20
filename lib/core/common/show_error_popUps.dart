import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A Dialog  that is displayed whenever any unexpected input is given by the user,
///
/// or some error occurs.
void showErrorDialog(
  BuildContext context, {
  required String titleText,
  required String contentText,
  required IconData icon,
  VoidCallback? onTap,
  String actionButtonText = "Try again",
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    CupertinoIcons.xmark_circle,
                    size: 25,
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                  ),
                ),
              ],
            ),
            CircleAvatar(
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
          ],
        ),
        title: Text(
          titleText,
        ),
        content: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                contentText,
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
                onPressed: onTap ??
                    () {
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
      );
    },
  );
}
