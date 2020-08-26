// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:flutter/cupertino.dart';
import 'pages/cart_page.dart';
import 'pages/setting_page.dart';
import 'pages/home_page.dart';

class Routes {
  Routes._();

  static const String home = "/home";
  static const String cart = "/cart";
  static const String setting = "/setting";

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    home: (context) => HomePage(),
    cart: (context) => CartPage(),
    setting: (context) => SettingPage(),
  };
}
