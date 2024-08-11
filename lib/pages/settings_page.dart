import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: ListTile(
        title: Text("Theme"),
        trailing: Switch(
          value: switchValue,
          onChanged: (value) {
            Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            
            setState(() {
              switchValue = !switchValue;
            });
          },
        ),
      ),
    );
  }
}
