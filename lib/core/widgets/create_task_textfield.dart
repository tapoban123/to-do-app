import 'package:flutter/material.dart';

class CreateTaskTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final OutlineInputBorder focusedBorder;
  final OutlineInputBorder enabledBorder;
  final TextInputAction textInputAction;
  final double? fontSize;
  final int? maxLines;

  const CreateTaskTextfield({
    super.key,
    required this.textController,
    required this.enabledBorder,
    required this.focusedBorder,
    required this.hintText,
    required this.textInputAction,
    this.fontSize,
    this.maxLines,
  });

  @override
  State<CreateTaskTextfield> createState() => _CreateTaskTextfieldState();
}

class _CreateTaskTextfieldState extends State<CreateTaskTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      decoration: InputDecoration(
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        hintText: widget.hintText,
      ),
      style: TextStyle(fontSize: widget.fontSize ?? widget.fontSize),
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.name,
      cursorColor: Colors.white,
      maxLines: widget.maxLines,
    );
  }
}
