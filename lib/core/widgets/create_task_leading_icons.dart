import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leadingIcon,
      title: Text(widget.titleText),
      trailing: Checkbox(
        activeColor: Colors.white.withOpacity(0.8),
        onChanged: widget.onChanged,
        value: widget.isChecked,
      ),
    );
  }
}
