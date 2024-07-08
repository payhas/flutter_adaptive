import 'package:flutter/material.dart';
import '../flutter_adaptive.dart';

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
