import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final ThemeData themeData = new ThemeData(
    brightness: Brightness.light,
    cardColor: Colors.white,
    dividerColor: Colors.grey[300],
    backgroundColor: Colors.grey[100],
    primaryColor: _MyColors.theme[500],
    primaryColorBrightness: Brightness.light,
    secondaryHeaderColor: Colors.white,
    accentColor: _MyColors.accent[500],
    primaryTextTheme: new Typography(platform: defaultTargetPlatform).white,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    accentIconTheme: const IconThemeData(color: Colors.white));

class _MyColors {
  _MyColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> theme = const <int, Color>{
    500: const Color(0xFFFBC812),
    600: const Color(0xFFFEAD22),
  };

  static const Map<int, Color> accent = const <int, Color>{
    500: const Color(0xFFF57C00),
  };
}
