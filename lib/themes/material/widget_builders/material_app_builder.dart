import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return MaterialApp(
      home: widget.home,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
}
