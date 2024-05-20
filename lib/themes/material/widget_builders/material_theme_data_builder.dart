import 'package:flutter/material.dart';
import 'package:flutter_adaptive/base/adaptive_theme_data.dart';
import 'package:flutter_adaptive/base/adaptive_theme_data_builder.dart';

class MaterialThemeDataBuilder extends AdaptiveThemeDataBuilder {
  @override
  ThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return ThemeData(
      brightness: component.brightness,
    );
  }
}
