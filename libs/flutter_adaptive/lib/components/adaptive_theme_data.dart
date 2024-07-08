import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveThemeData with AdaptiveComponent {
  const AdaptiveThemeData({this.brightness});

  final Brightness? brightness;
}
