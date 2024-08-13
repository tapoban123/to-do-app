import 'package:flutter/material.dart';

class ReminderOption extends StatelessWidget {
  final String tileLabel;
  final VoidCallback onTap;
  final TextEditingController textController;

  const ReminderOption({
    super.key,
    required this.onTap,
    required this.textController,
    required this.tileLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextFormField(
        controller: textController,
        readOnly: true,
        decoration: InputDecoration(
          label: Text(tileLabel),
        ),
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        onTap: onTap,
        textAlign: TextAlign.center,
      ),
    );
  }
}
