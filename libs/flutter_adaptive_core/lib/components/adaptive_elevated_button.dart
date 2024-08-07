import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveElevatedButton extends AdaptiveWidget {
  const AdaptiveElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
