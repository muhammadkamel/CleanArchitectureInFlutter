import 'package:flutter/material.dart';

extension AppThemeColorsX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;

  Color get primaryColor => theme.primaryColor;
  Color get secondaryColor => theme.secondaryHeaderColor;
  Color get cardColor => theme.cardColor;
  Color get backgroundColor => colorScheme.surface;
  Color get dividerColor => theme.dividerColor;
  Color get shadowColor => theme.shadowColor;
  Color get disabledColor => theme.disabledColor;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get onSecondaryColor => colorScheme.onSecondary;
  Color get onCardColor => colorScheme.onSurface;
  Color get onBackgroundColor => colorScheme.onSurface;
  Color get onDividerColor => colorScheme.onSurface;
  Color get onShadowColor => colorScheme.onSurface;
  Color get errorColor => colorScheme.error;
  Color get onErrorColor => colorScheme.onError;
  Color get onDisabledColor => colorScheme.onSurface;
}
