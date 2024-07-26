import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUIAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    MacosThemeData data = component.theme?.build(context);
    return MacosApp(
      // theme: component.theme?.build(context),
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: data.brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
    );
  }
}
