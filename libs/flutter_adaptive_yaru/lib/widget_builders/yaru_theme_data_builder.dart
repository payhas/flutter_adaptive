import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:yaru/theme.dart';

class YaruThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  static YaruThemeData? yaruThemeData;

  @override
  build(BuildContext context, AdaptiveThemeData component) {
    yaruThemeData ??= context.findAncestorWidgetOfExactType<YaruTheme>()?.data;

    return component.brightness == Brightness.light
        ? yaruThemeData?.theme ?? yaruViridianLight
        : yaruThemeData?.darkTheme ?? yaruViridianDark;
  }
}
