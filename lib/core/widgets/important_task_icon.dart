import 'package:flutter/material.dart';

/// Icon implemented as the leadingIcon to mark a task as IMPORTANT.
class ImportantTaskIcon extends StatelessWidget {
  const ImportantTaskIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xffFFF600),
          Color(0xffFFC302),
          Color(0xffFF8F00),
          Color(0xffFF5B00),
          Color(0xffFF0505),
        ],
      ).createShader(bounds),
      child: Icon(
        Icons.warning_amber_outlined,
      ),
    );
  }
}
