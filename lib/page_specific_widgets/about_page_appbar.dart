import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/about_page.dart';

/// AppBar implemented in the [AboutPage].
class AboutPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  AboutPageAppbar({super.key})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("ABOUT"),
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      forceMaterialTransparency: false,
    );
  }
}
