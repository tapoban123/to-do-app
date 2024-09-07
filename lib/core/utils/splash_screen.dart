import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_todo_app/pages/drawer_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> animation;
  late Timer navigationTimer;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.ease,
    );

    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          fadeController.reverse();
        }
      },
    );

    fadeController.forward();

    navigationTimer = Timer(
      Duration(seconds: 1, milliseconds: 600),
      () {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DrawerNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: Offset(1, 0), end: Offset.zero).chain(
              CurveTween(curve: Curves.ease),
            );
            final position = animation.drive(tween);

            return SlideTransition(
              position: position,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 200),
        ));
      },
    );
  }

  @override
  void dispose() {
    fadeController.dispose();
    navigationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Shader textGradient = LinearGradient(
      colors: [
        Color(0xffc642b2),
        Color(0xff184da7),
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 450.0, 700.0),
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: FadeTransition(
          opacity: animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 400,
                child: Image.asset(
                  "assets/images/sticky-note.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "QuickList",
                style: TextStyle(
                  fontSize: 26,
                  letterSpacing: 5,
                  fontFamily: "RobotoSlab",
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = textGradient,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
