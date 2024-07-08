import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

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
