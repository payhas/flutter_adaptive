import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  CupertinoThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return CupertinoThemeData(
      brightness: component.brightness,
    );
  }
}
