import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/components/adaptive_app.dart';

class CupertinoAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return CupertinoApp(
      theme: component.theme?.build(context),
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
    );
  }
}
