import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

import '../base/adaptive_theme_data.dart';

class AdaptiveApp extends AdaptiveWidget {
  const AdaptiveApp({
    super.key,
    this.home,
    this.theme,
    this.debugShowCheckedModeBanner = true,
  });

  final Widget? home;
  final AdaptiveThemeData? theme;
  final bool debugShowCheckedModeBanner;
}
