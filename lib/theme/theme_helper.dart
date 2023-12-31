import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.gray500,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.background;
          }
          return colorScheme.onSurface;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: colorScheme.background,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 40.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w800,
        ),
        displaySmall: TextStyle(
          color: colorScheme.background,
          fontSize: 36.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontSize: 30.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 25.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray700,
          fontSize: 12.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontSize: 11.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.gray400,
          fontSize: 16.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorScheme.background,
          fontSize: 15.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XFF5B5551),
    primaryContainer: Color(0XFFFFFFFF),
    secondary: Color(0XFFFFFFFF),
    secondaryContainer: Color(0XFF5B5450),
    tertiary: Color(0XFFFFFFFF),
    tertiaryContainer: Color(0XFF5B5450),

    // Background colors
    background: Color(0XFFFFFFFF),

    // Surface colors
    surface: Color(0XFFFFFFFF),
    surfaceTint: Color(0XFFFFFFFF),
    surfaceVariant: Color(0XFF5B5450),

    // Error colors
    error: Color(0XFFFFFFFF),
    errorContainer: Color(0XFF5B5450),
    onError: Color(0XFF5B5450),
    onErrorContainer: Color(0XFFFFFFFF),

    // On colors(text colors)
    onBackground: Color(0XFF5B5450),
    onInverseSurface: Color(0XFF5B5450),
    onPrimary: Color(0XFFFFFFFF),
    onPrimaryContainer: Color(0XFF5B5450),
    onSecondary: Color(0XFF5B5450),
    onSecondaryContainer: Color(0XFFFFFFFF),
    onTertiary: Color(0XFF5B5450),
    onTertiaryContainer: Color(0XFFFFFFFF),

    // Other colors
    outline: Color(0XFFFFFFFF),
    outlineVariant: Color(0XFFFFFFFF),
    scrim: Color(0XFFFFFFFF),
    shadow: Color(0XFFFFFFFF),

    // Inverse colors
    inversePrimary: Color(0XFFFFFFFF),
    inverseSurface: Color(0XFFFFFFFF),

    // Pending colors
    onSurface: Color(0XFF5B5450),
    onSurfaceVariant: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);

  // Blue
  Color get blue50 => Color(0XFFEDF7FD);

  // BlueGray
  Color get blueGray100 => Color(0XFFD9D9D9);
  Color get blueGray400 => Color(0XFF888888);

  // Gray
  Color get gray100 => Color(0XFFF6F6F6);
  Color get gray200 => Color(0XFFE7E7E7);
  Color get gray400 => Color(0XFFBDBDBD);
  Color get gray40001 => Color(0XFFD2C8C2);
  Color get gray50 => Color(0XFFFAFAFA);
  Color get gray500 => Color(0XFF9B9189);
  Color get gray600 => Color(0XFF78726E);
  Color get gray60001 => Color(0XFF827B77);
  Color get gray700 => Color(0XFF6D6661);
  Color get gray70001 => Color(0XFF5C5652);

  // Red
  Color get red50 => Color(0XFFFAF1EC);

  // Green
  Color get greeen400 => Color(0XFF76FF03);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
