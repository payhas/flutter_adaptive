import 'package:flutter/widgets.dart';
import '../base/adaptive_widget.dart';

class AdaptiveApp extends AdaptiveWidget {
  const AdaptiveApp({
    super.key,
    required this.home,
    this.debugShowCheckedModeBanner = true,
  });

  final Widget home;
  final bool debugShowCheckedModeBanner;
}
