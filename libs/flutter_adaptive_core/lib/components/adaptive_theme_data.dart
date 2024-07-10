import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveThemeData with AdaptiveComponent {
  const AdaptiveThemeData({this.brightness});

  final Brightness? brightness;
}
