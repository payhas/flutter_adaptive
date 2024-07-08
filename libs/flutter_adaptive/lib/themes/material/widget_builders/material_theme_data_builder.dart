import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  ThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return ThemeData(brightness: component.brightness, useMaterial3: true);
  }
}
