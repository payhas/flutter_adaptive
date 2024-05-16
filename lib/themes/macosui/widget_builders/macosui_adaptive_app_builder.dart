import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/common/adaptive_app.dart';

class MacosUIAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return MacosApp(
      theme: MacosThemeData(brightness: widget.theme?.brightness),
      home: widget.home,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
}
