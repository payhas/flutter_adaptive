import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'adaptive_component.dart';

class AdaptiveThemeData with AdaptiveComponent {
  const AdaptiveThemeData({this.brightness});

  final Brightness? brightness;

  @override
  dynamic build(BuildContext context) {
    var builder =
        Adaptive.of(context)?.getBuilder<AdaptiveThemeData, dynamic>(name);
    return builder?.build(context, this);
  }
}
