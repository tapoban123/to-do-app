import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/widgets/about_page_text_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  ButtonStyle textButtonTheme = TextButton.styleFrom(
    backgroundColor: Color(0xff1E201E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    minimumSize: Size(100, 50),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0).copyWith(top: 30),
            child: RichText(
              text: TextSpan(
                text: aboutTheAppTitle,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .color!
                      .withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  wordSpacing: 4,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: SizedBox(
              width: 100,
              child: Divider(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              text: TextSpan(
                text: aboutTheApp,
                style: TextStyle(
                  fontFamily: "RobotoSlab",
                  color: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .color!
                      .withOpacity(0.6),
                  wordSpacing: 3,
                  height: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            height: 650,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "About the Developer",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "RobotoSlab",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/my_photo.png"),
                  radius: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            Text(
                              "Hello! I'm Tapoban Ray, a passionate Android Developer with a love for creating user-friendly and practical applications.",
                              style: TextStyle(fontFamily: "RobotoSlab"),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Currently, I'm persuing B.Tech course in Computer Science Engineering at Calcutta Institute of Engineering and Management (CIEM).",
                              style: TextStyle(fontFamily: "RobotoSlab"),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 30.0,
                    bottom: 15,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Contact me on:",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "RobotoSlab",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AboutPageTextButton(
                            buttonText: "GitHub",
                            leadingWidget: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/github_logo.png"),
                              backgroundColor: Colors.white,
                              radius: 15,
                            ),
                            navigateToUrl:
                                Uri.parse("https://github.com/tapoban123"),
                          ),
                          AboutPageTextButton(
                            buttonText: "Linkedin",
                            leadingWidget: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/linkedin_logo.png"),
                              backgroundColor: Colors.white,
                              radius: 15,
                            ),
                            navigateToUrl: Uri.parse(
                                "https://www.linkedin.com/in/tapobanray"),
                          ),
                          AboutPageTextButton(
                            buttonText: "Twitter",
                            leadingWidget: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/twitter_logo.png"),
                              backgroundColor: Colors.white,
                              radius: 15,
                            ),
                            navigateToUrl:
                                Uri.parse("https://x.com/tapoban_ray"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutPageTextButton(
                        buttonText: "Mail",
                        leadingWidget: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.white,
                        ),
                        navigateToUrl: Uri(
                          scheme: "mailto",
                          path: "developertapobanray@gmail.com",
                        ),
                        buttonWidth: double.infinity,
                        launchMode: LaunchMode.externalApplication,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final String aboutTheAppTitle =
      '"Stay Ahead of Your Day with Quick List - Your Ultimate Task Manager!"';

  final String aboutTheApp =
      "Welcome to our To-Do List app, designed to make your life easier with its user-friendly interface and intuitive design. Managing tasks is a breeze—whether you're scheduling meetings, setting reminders, or creating simple to-do lists. With timely notifications, you'll never miss an important task, helping you stay organized and boost your productivity effortlessly.";
}
