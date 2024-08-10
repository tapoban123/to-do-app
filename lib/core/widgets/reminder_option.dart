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
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          label: Text(tileLabel),
        ),
        style: const TextStyle(color: Colors.white),
        onTap: onTap,
        textAlign: TextAlign.center,
      ),
    );
  }
}
