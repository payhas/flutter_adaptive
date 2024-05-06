import 'package:flutter/material.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/common/adaptive_app.dart';

class CupertinoAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return MaterialApp(
      home: widget.home,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
}
