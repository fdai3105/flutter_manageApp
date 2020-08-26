import 'package:flutter/material.dart';
import 'app_keys.dart';

class Themes {
  static ThemeData theme() {
    return ThemeData(
      // toggleableActiveColor for switch button and header text
      brightness: Brightness.light,
      backgroundColor: AppKeys.kLightColorBG,
      cardColor: AppKeys.kLightColorCard,
      iconTheme: IconThemeData(color: AppKeys.kLightColorIcon),
      textTheme: TextTheme(
          // headline6 for appbar title
          // subtitle 1 for title
          headline6: TextStyle(color: AppKeys.kLightColorText),
          subtitle1: TextStyle(color: AppKeys.kLightColorText),
          bodyText1: TextStyle(color: AppKeys.kLightColorText),
          bodyText2: TextStyle(color: AppKeys.kLightColorText),
          subtitle2: TextStyle(
            color: AppKeys.kLightColorText,
          )),
      buttonColor: AppKeys.kLightColorButton,
      toggleableActiveColor: Colors.deepOrange,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              TextStyle(color: AppKeys.kLightColorText.withOpacity(0.7)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 2))),
    );
  }

  static ThemeData themeDark() {
    return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: AppKeys.kDarkColorBG,
      cardColor: AppKeys.kDarkColorCard,
      iconTheme: IconThemeData(color: AppKeys.kDarkColorIcon),
      textTheme: TextTheme(
        headline6: TextStyle(color: AppKeys.kDarkColorText),
        subtitle1: TextStyle(color: AppKeys.kDarkColorText),
        bodyText1: TextStyle(color: AppKeys.kDarkColorText),
        bodyText2: TextStyle(color: AppKeys.kDarkColorText.withOpacity(0.8)),
        subtitle2: TextStyle(color: AppKeys.kLightColorText),
        button: TextStyle(color: AppKeys.kDarkColorText, fontSize: 14),
      ),
      buttonColor: AppKeys.kDarkColorButton,
      toggleableActiveColor: Colors.deepOrange,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppKeys.kDarkColorText.withOpacity(0.7)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70, width: 2))),
    );
  }
}
