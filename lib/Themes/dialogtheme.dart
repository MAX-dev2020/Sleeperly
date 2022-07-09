import 'package:flutter/material.dart';

ThemeData buildDialogTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _DialogColorScheme,
    toggleableActiveColor: Dialogblack,
    primaryColor: Dialogblack,
    scaffoldBackgroundColor: DialogBackgroundWhite,
    cardColor: DialogBackgroundWhite,
    errorColor: DialogErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _DialogColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: DialogBackgroundWhite,
    ),
    textTheme: _buildDialogTextTheme(base.textTheme),
    primaryTextTheme: _buildDialogTextTheme(base.primaryTextTheme),
  );
}

TextTheme _buildDialogTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        bodyText1: base.bodyText1?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        subtitle1: base.subtitle1?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      )
      .apply(
        fontFamily: 'Montserrat',
      );
}

const ColorScheme _DialogColorScheme = ColorScheme(
  primary: Dialogblack,
  secondary: Dialogblack,
  surface: DialogSurfaceWhite,
  background: DialogBackgroundWhite,
  error: DialogErrorRed,
  onPrimary: DialogSurfaceWhite,
  onSecondary: Dialogblack,
  onSurface: Dialogblack,
  onBackground: Dialogblack,
  onError: DialogSurfaceWhite,
  brightness: Brightness.light,
);

const Color Dialogblack = Color.fromARGB(255, 0, 0, 0);
const Color DialogErrorRed = Color(0xFFC5032B);
const Color DialogSurfaceWhite = Color(0xFFFFFBFA);
const Color DialogBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
