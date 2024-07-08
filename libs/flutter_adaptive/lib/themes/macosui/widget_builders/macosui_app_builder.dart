import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../base/adaptive_widget_builder.dart';
import '../../../components/adaptive_app.dart';

class MacosUIAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return MacosApp(
      theme: component.theme?.build(context),
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
    );
  }
}
