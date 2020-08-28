// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:flutter/material.dart';

class AppKeys {
  AppKeys();

  //
  static const kBlueButton = Color(0xFF11cbd7);
  static const kRedButton = Color(0xFFFA4659);

  //
  static const kBlurDefault = 3.0;

  //
  static const kLightColorBG = Colors.white;
  static Color kLightColorCard = Colors.black.withOpacity(0.05);
  static Color kLightColorText = Colors.black87.withOpacity(0.8);
  static const kLightColorTextDark = Colors.white;
  static const kLightColorButton = Color(0xFF11cbd7); // 0xFFFA4659
  static const kLightColorIcon = Colors.black87;
  //
  static const kDarkColorBG = Color(0xFF3C3D42);
  static const kDarkColorText = Colors.white;
  static const kDarkColorTextLight = Colors.black87;
  static const kDarkColorCard = Colors.black26;
  static const kDarkColorButton = Color(0xFF11cbd7);
  static const kDarkColorIcon = Colors.white;

  // Share pref keys
  static const String kSharePrefDarkMode = "DARK_MODE";

}
