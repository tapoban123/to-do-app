import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';
import 'package:simple_todo_app/core/widgets/about_page_text_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// This page `displays a brief description` of the application along with
/// an introduction of it's developer and the developer's contact info
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late Color paragraphFontColor;

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
                text: '"Stay Ahead of Your Day with ',
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .color!
                      .withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  wordSpacing: 4,
                  fontSize: 32,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'QuickList - Your Ultimate Task Manager!"',
                    style: TextStyle(color: Colors.amber[700]),
                  )
                ],
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
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              if (themeProvider.getCurrentTheme == ThemeData.dark()) {
                paragraphFontColor = Colors.greenAccent;
              } else {
                paragraphFontColor = Colors.pinkAccent;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: RichText(
                  text: TextSpan(
                    text:
                        "Welcome to our To-Do List app, designed to make your life easier with its ",
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
                    children: <TextSpan>[
                      TextSpan(
                        text: "user-friendly interface ",
                        style: TextStyle(color: paragraphFontColor),
                      ),
                      TextSpan(
                        text: "and ",
                      ),
                      TextSpan(
                        text: "intuitive design ",
                        style: TextStyle(color: paragraphFontColor),
                      ),
                      TextSpan(
                        text:
                            "Managing tasks is a breeze—whether you're scheduling meetings, setting reminders, or creating simple to-do lists. ",
                      ),
                      TextSpan(
                        text:
                            "With timely notifications, you'll never miss an important task, helping you stay organized and boost your productivity effortlessly. ",
                        style: TextStyle(color: paragraphFontColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            height: 405,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff0052D4),
                  Color(0xff4364F7),
                  Color(0xff6FB1FC),
                ],
              ),
              color: Colors.blueAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 25,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "About the Developer",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "RobotoSlab",
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: "RobotoSlab",
                                  wordSpacing: 3,
                                  height: 1.5,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Tapoban Ray",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\nA passionate Android Developer ",
                                    style: TextStyle(
                                      height: 2,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "with a love for creating user-friendly and practical applications. ",
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Divider(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
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
                      "Contact the Developer :",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "RobotoSlab",
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
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
}
