import 'package:flutter/material.dart';

import '../base/adaptive_component.dart';

class AdaptiveThemeData with AdaptiveComponent {
  const AdaptiveThemeData({this.brightness});

  final Brightness? brightness;
}
