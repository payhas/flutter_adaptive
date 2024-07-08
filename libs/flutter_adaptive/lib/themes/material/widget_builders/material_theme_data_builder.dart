import 'package:flutter/material.dart';
import '../../../base/adaptive_component_builder.dart';
import '../../../components/adaptive_theme_data.dart';

class MaterialThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  ThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return ThemeData(brightness: component.brightness, useMaterial3: true);
  }
}
