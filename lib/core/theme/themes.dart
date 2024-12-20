import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/core/theme/theme_provider.dart';

class CustomThemes {
  /// Implements `custom themes for specific components of the application`.
  ///
  /// The themes change as per the main theme of the application, that is, DarkMode or LightMode.
  CustomThemes();

  ThemeData _getCurrentTheme(BuildContext context) {
    return Provider.of<ThemeProvider>(context).getCurrentTheme;
  }

  Color _setThemeSpecificFontColor(ThemeData currentTheme) {
    if (currentTheme == ThemeData.dark()) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  /// Sets `custom theme for every AppBar` implemented in the application.
  AppBarTheme getCustomAppBarTheme(BuildContext context) {
    final _currentTheme = _getCurrentTheme(context);

    Color fontColor = _setThemeSpecificFontColor(_currentTheme);

    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: _currentTheme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: _currentTheme == ThemeData.dark()
            ? Brightness.light
            : Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        fontFamily: "OpenSans",
        fontWeight: FontWeight.w900,
        color: fontColor,
        letterSpacing: 5,
        fontSize: 18,
      ),
    );
  }

  /// Sets `custom theme for every ListTile widget` implemented throughout the application.
  ListTileThemeData getCustomListTileTheme(BuildContext context) {
    final ThemeData _currentTheme = _getCurrentTheme(context);

    Color fontColor = _setThemeSpecificFontColor(_currentTheme);

    return ListTileThemeData(
      titleTextStyle: TextStyle(
        inherit: true,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        color: fontColor,
      ),
      iconColor: fontColor,
      selectedColor: fontColor,
      subtitleTextStyle: TextStyle(
        inherit: true,
        fontFamily: "OpenSans",
        fontWeight: FontWeight.w500,
        color: fontColor.withOpacity(0.5),
        fontSize: 14,
      ),
    );
  }

  /// `Custom theme for texts` in the application.
  ///
  /// Implemented for some specific texts of the application.
  TextTheme getCustomTextTheme(BuildContext context) {
    ThemeData _currentTheme = _getCurrentTheme(context);

    Color fontColor = _setThemeSpecificFontColor(_currentTheme);

    return TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
        color: fontColor,
        fontFamily: "OpenSans",
      ),
    );
  }

  /// `Custom themes for the Dialogs` displayed throughout the application.
  DialogTheme getCustomDialogTheme(BuildContext context) {
    ThemeData _currentTheme = _getCurrentTheme(context);

    Color fontColor = _setThemeSpecificFontColor(_currentTheme);

    return DialogTheme(
      titleTextStyle: TextStyle(
        fontSize: 30,
        color: fontColor,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        fontSize: 15,
        color: fontColor,
      ),
    );
  }

  /// `Custom TextField theme` implemented on every TextField of the application.
  InputDecorationTheme getTextFormFieldTheme(BuildContext context) {
    final _currentTheme = _getCurrentTheme(context);

    Color fontColor = _setThemeSpecificFontColor(_currentTheme);

    Color borderColor;
    Color focusedBorderColor;

    if (_currentTheme == ThemeData.dark()) {
      borderColor = Colors.white.withOpacity(0.5);
      focusedBorderColor = Colors.white;
    } else {
      borderColor = Color(0xff9394a5);
      focusedBorderColor = Color(0xff484b6a);
    }

    return InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      hintStyle: TextStyle(
        color: fontColor.withOpacity(0.4),
        fontFamily: "OpenSans",
      ),
      labelStyle: TextStyle(
        color: fontColor,
        fontFamily: "OpenSans",
      ),
    );
  }
}
