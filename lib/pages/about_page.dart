import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     RootScaffold.openDrawer(context);
        //   },
        //   icon: Icon(Icons.menu_rounded),
        // ),

        title: Text("About Page"),
      ),
    );
  }
}
