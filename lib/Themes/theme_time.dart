import 'package:flutter/material.dart';

ThemeData buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    toggleableActiveColor: shrineblack,
    primaryColor: shrineblack,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        bodyText1: base.bodyText1?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        subtitle1: base.subtitle1?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      )
      .apply(
        fontFamily: 'Montserrat',
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrineblack,
  secondary: shrineblack,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineSurfaceWhite,
  onSecondary: shrineblack,
  onSurface: shrineblack,
  onBackground: shrineblack,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrineblack = Color.fromARGB(255, 0, 0, 0);
const Color shrineErrorRed = Color(0xFFC5032B);
const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
