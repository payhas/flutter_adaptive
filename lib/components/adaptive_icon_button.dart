import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveIconButton extends AdaptiveWidget {
  const AdaptiveIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Widget icon;
  final VoidCallback onPressed;
}
