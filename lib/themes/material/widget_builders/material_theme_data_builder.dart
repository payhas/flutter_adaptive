import 'package:flutter/material.dart';
import 'package:flutter_adaptive/base/adaptive_component_builder.dart';
import 'package:flutter_adaptive/common/adaptive_theme_data.dart';

class MaterialThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  ThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return ThemeData(
      brightness: component.brightness,
    );
  }
}
