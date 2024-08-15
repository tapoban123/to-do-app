import 'package:flutter/cupertino.dart';

/// Icon that has been used to mark a task as a ScheduledTask.
class ScheduledTaskIcon extends StatelessWidget {
  const ScheduledTaskIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const [
          Color(0xfffffdb8),
          Color(0xfffdf68c),
          Color(0xfff4cd2a),
          Color(0xffeda323),
          Color(0xffd28d0d),
        ],
      ).createShader(bounds),
      child: Icon(
        CupertinoIcons.bell_fill,
      ),
    );
  }
}
