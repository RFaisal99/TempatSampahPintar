import 'package:flutter/material.dart';
import 'package:stb/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBackground => BoxDecoration(
        color: theme.colorScheme.background,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray500,
      );
  static BoxDecoration get fillGray70001 => BoxDecoration(
        color: appTheme.gray70001,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red50,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
    color: appTheme.greeen400,
  );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder37 => BorderRadius.circular(
        37.h,
      );

  // Custom borders
  static BorderRadius get customBorderBL40 => BorderRadius.only(
        topLeft: Radius.circular(30.h),
        topRight: Radius.circular(30.h),
        bottomLeft: Radius.circular(40.h),
        bottomRight: Radius.circular(40.h),
      );
  static BorderRadius get customBorderLR10 => BorderRadius.horizontal(
        right: Radius.circular(10.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder30 => BorderRadius.circular(
        30.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
