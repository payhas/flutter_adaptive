import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruTheme;
import 'package:yaru/theme.dart';

class YaruThemeDataBuilder extends AdaptiveThemeDataBuilder {
  static YaruThemeData? yaruThemeData;

  @override
  build(BuildContext context, AdaptiveThemeData component) {
    yaruThemeData ??=
        context.findAncestorWidgetOfExactType<YaruTheme>()?.data;

    return component.brightness == Brightness.light
        ? yaruThemeData?.theme ?? yaruViridianLight
        : yaruThemeData?.darkTheme ?? yaruViridianDark;
  }
}
