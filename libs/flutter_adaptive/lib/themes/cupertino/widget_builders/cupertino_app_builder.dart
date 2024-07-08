import 'package:flutter/cupertino.dart';
import '../../../base/adaptive_widget_builder.dart';
import '../../../components/adaptive_app.dart';

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
