import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return MaterialApp(
      theme: component.theme?.build(context),
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
    );
  }
}
