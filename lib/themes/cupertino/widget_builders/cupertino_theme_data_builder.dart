import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoThemeDataBuilder extends AdaptiveThemeDataBuilder {
  @override
  CupertinoThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return CupertinoThemeData(
      brightness: component.brightness,
    );
  }
}
