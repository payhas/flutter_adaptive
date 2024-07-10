import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_yaru/widget_builders/yaru_theme_data_builder.dart';
import 'package:yaru/yaru.dart';

class YaruAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return YaruTheme(
      builder: (context, yaru, child) {
        YaruThemeDataBuilder.yaruThemeData = yaru;
        return MaterialApp(
          theme: component.theme?.build(context),
          home: component.home,
          debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
        );
      },
    );
  }
}
