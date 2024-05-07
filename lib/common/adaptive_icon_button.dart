import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveIconButton extends AdaptiveWidget {
  const AdaptiveIconButton(
    this.onPressed, {
    super.key,
    required this.icon,
  });

  final Widget icon;
  final VoidCallback onPressed;
}
