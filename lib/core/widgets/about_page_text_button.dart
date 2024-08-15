import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageTextButton extends StatelessWidget {
  final Widget leadingWidget;
  final String buttonText;
  final Uri navigateToUrl;
  final double buttonWidth;
  final LaunchMode launchMode;

  const AboutPageTextButton({
    super.key,
    required this.buttonText,
    required this.leadingWidget,
    required this.navigateToUrl,
    this.launchMode = LaunchMode.inAppBrowserView,
    this.buttonWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff191f22),
            Color(0xff131618),
            Color(0xff0d0c0b),
            Color(0xff060505),
            Color(0xff000000),
          ],
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(buttonWidth, 50),
        ),
        onPressed: () async {
          Uri githubUrl = navigateToUrl;
          await launchUrl(
            githubUrl,
            mode: launchMode,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   backgroundImage: AssetImage(leadingImagePath),
            //   backgroundColor: Colors.white,
            //   radius: 15,
            // ),
            leadingWidget,
            SizedBox(
              width: 5,
            ),
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "RobotoSlab",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
