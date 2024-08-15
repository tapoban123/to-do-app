import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/create_task_page.dart';

/// This TextField is implemented in [CreateTaskPage].
/// 
/// `TaskTitle` and `TaskDescription` have been implemented using this TextField.
class CreateTaskTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final TextInputAction textInputAction;
  final double? fontSize;
  final int? maxLines;

  const CreateTaskTextfield({
    super.key,
    required this.textController,
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
        hintText: widget.hintText,
      ),
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontSize: widget.fontSize ?? widget.fontSize),
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.multiline,
      cursorColor: Theme.of(context).textTheme.headlineMedium!.color,
      maxLines: widget.maxLines,
    );
  }
}
