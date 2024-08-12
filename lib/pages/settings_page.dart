import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool switchValue;
  late Color switchThumbColor;

  @override
  Widget build(BuildContext context) {
    switchValue = Provider.of<ThemeProvider>(context).isDarkTheme();

    if (switchValue == false) {
      switchThumbColor = Colors.black;
    } else {
      switchThumbColor = Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: ListTile(
        title: Text("Theme"),
        trailing: CupertinoSwitch(
          thumbColor: switchThumbColor,
          activeColor: Colors.grey[350],
          value: !switchValue,
          dragStartBehavior: DragStartBehavior.down,
          onChanged: (value) {
            if (switchValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .changeTheme(toDarkTheme: false);
            } else {
              Provider.of<ThemeProvider>(context, listen: false)
                  .changeTheme(toDarkTheme: true);
            }

            setState(() {
              switchValue = !switchValue;
            });
          },
        ),
      ),
    );
  }
}
