import 'package:flutter/material.dart';

final _defaultTextStyle = const TextStyle().copyWith();

extension TextThemeX on BuildContext {
  TextTheme get getTextTheme => Theme.of(this).textTheme;

  /// Display
  TextStyle get displayLarge => getTextTheme.displayLarge ?? _defaultTextStyle;
  TextStyle get displayMedium =>
      getTextTheme.displayMedium ?? _defaultTextStyle;
  TextStyle get displaySmall => getTextTheme.displaySmall ?? _defaultTextStyle;

  /// Headline
  TextStyle get headlineLarge =>
      getTextTheme.headlineLarge ?? _defaultTextStyle;
  TextStyle get headlineMedium =>
      getTextTheme.headlineMedium ?? _defaultTextStyle;
  TextStyle get headlineSmall =>
      getTextTheme.headlineSmall ?? _defaultTextStyle;

  /// Title
  TextStyle get titleLarge => getTextTheme.titleLarge ?? _defaultTextStyle;
  TextStyle get titleMedium => getTextTheme.titleMedium ?? _defaultTextStyle;
  TextStyle get titleSmall => getTextTheme.titleSmall ?? _defaultTextStyle;

  /// Body
  TextStyle get bodyLarge => getTextTheme.bodyLarge ?? _defaultTextStyle;
  TextStyle get bodyMedium => getTextTheme.bodyMedium ?? _defaultTextStyle;
  TextStyle get bodySmall => getTextTheme.bodySmall ?? _defaultTextStyle;

  /// Label
  TextStyle get labelLarge => getTextTheme.labelLarge ?? _defaultTextStyle;
  TextStyle get labelMedium => getTextTheme.labelMedium ?? _defaultTextStyle;
  TextStyle get labelSmall => getTextTheme.labelSmall ?? _defaultTextStyle;
}
