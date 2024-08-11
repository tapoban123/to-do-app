import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message,
  Color snackBarColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: snackBarColor,
      showCloseIcon: true,
      dismissDirection: DismissDirection.horizontal,
      closeIconColor: Colors.white,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}
