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
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color(0xff1E201E),
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
    );
  }
}
