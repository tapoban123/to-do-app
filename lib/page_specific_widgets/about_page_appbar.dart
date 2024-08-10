import 'package:flutter/material.dart';

class AboutPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  AboutPageAppbar({super.key})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("About Page"),
    );
  }
}
