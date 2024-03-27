import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'package:gooloads/src/utils/constants/palette.dart';

class AppTheme {
  ThemeData _darkTheme = ThemeData(
    fontFamily: KFontFam,
    primaryColor: Palette.KBlackClr,
    accentColor: Palette.KWhiteClr,
    scaffoldBackgroundColor: Colors.black54,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Palette.KTransparentClr,
    ),
  );

  ThemeData _lightTheme = ThemeData(
    fontFamily: KFontFam,
    primaryColor: Palette.KWhiteClr,
    accentColor: Palette.KBlackClr,
    scaffoldBackgroundColor: Palette.KWhitishClr,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Palette.KTransparentClr,
    ),
  );

  ThemeData get getDarkTheme => _darkTheme;
  ThemeData get getLightTheme => _lightTheme;
}
