import 'package:flutter/material.dart';
import '../flutter_adaptive.dart';

class AdaptiveAppBar extends AdaptiveWidget {
  const AdaptiveAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
  });

  final Widget? leading;
  final Widget? title;
  final List<AdaptiveAppBarAction>? actions;
}

class AdaptiveAppBarAction {
  AdaptiveAppBarAction(
      {required this.onPressed, required this.icon, this.label});

  final VoidCallback onPressed;
  final Widget icon;
  final Widget? label;
}
