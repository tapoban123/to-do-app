import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';

class CreateTaskLeadingIcons extends StatefulWidget {
  final bool isChecked;
  final String titleText;
  final Function(bool?) onChanged;
  final Widget leadingIcon;

  const CreateTaskLeadingIcons({
    super.key,
    required this.titleText,
    required this.isChecked,
    required this.onChanged,
    required this.leadingIcon,
  });

  @override
  State<CreateTaskLeadingIcons> createState() => _CreateTaskLeadingIconsState();
}

class _CreateTaskLeadingIconsState extends State<CreateTaskLeadingIcons> {
  late Color checkBoxActiveColor;
  late Color checkBoxMarkColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final _currentTheme = themeProvider.getCurrentTheme;

        if (_currentTheme == ThemeData.dark()) {
          checkBoxActiveColor = Colors.white.withOpacity(0.8);
          checkBoxMarkColor = Colors.black;
        } else {
          checkBoxActiveColor = Colors.grey[850]!;
          checkBoxMarkColor = Colors.white;
        }

        return ListTile(
          leading: widget.leadingIcon,
          title: Text(widget.titleText),
          trailing: Checkbox(
            activeColor: checkBoxActiveColor,
            checkColor: checkBoxMarkColor,
            onChanged: widget.onChanged,
            value: widget.isChecked,
          ),
        );
      },
    );
  }
}
