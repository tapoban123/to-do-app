import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About the application",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          RichText(
            text: TextSpan(
              text: aboutTheApp,
              style: TextStyle(
                fontFamily: "RobotoSlab",
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "\n\u2022 User-Friendly Interface: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "Navigate with ease and organize your tasks quickly, thanks to our intuitive design.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text: "\n\u2022 Easy Task Management: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "Whether it's scheduling important meetings, setting reminders for deadlines, or creating simple to-do lists, our app makes it simple.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text: "\n\u2022 Timely Notifications: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "Stay on top of your day with notifications that ensure you never miss a task.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text: "\n\u2022 Boost Your Productivity: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  children: [
                    TextSpan(
                      text:
                          "Focus on getting things done with an app that is incredibly easy to use and helps you stay organized.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text:
                      "\n\nSimplify your life and take control of your tasks with our all-in-one task management solution!",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final String aboutTheApp =
      "Our To-Do Task application is designed to help you manage your tasks effortlessly. Here’s what makes our app stand out:";
}
