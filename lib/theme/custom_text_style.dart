import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumOpenSans =>
      theme.textTheme.bodyMedium!.openSans.copyWith(
        fontSize: 15.fSize,
      );
  static get bodyMediumOpenSansOnPrimary =>
      theme.textTheme.bodyMedium!.openSans.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 15.fSize,
      );
  // Display text style
  static get displayMediumBackground => theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.background,
      );
  static get displaySmallOnPrimary => theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get displaySmallOnSecondary => theme.textTheme.displaySmall!.copyWith(
    color: theme.colorScheme.onPrimary,
  );
  // Headline text style
  static get headlineSmallBackground => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.background,
        fontWeight: FontWeight.w800,
      );
  static get headlineSmallExtraBold => theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w800,
      );
  // Label text style
  static get labelMediumGray600 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray600,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumGray60002 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray60001,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
      );
  // Title text style
  static get titleLargeBackground => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.background,
        fontWeight: FontWeight.w800,
      );
  static get titleLargeExtraBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w800,
      );
  static get titleLargeInter => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeInterBackground =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.background,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeOnSecondary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSecondary,
        fontWeight: FontWeight.w800,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumInterBackground =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.background,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterBlack900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterOnPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOpenSansGray400 =>
      theme.textTheme.titleMedium!.openSans.copyWith(
        color: appTheme.gray400,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallExtraBold => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallExtraBold14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallOnPrimaryExtraBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w800,
      );
}

extension on TextStyle {
  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }
}
