import 'package:flutter/widgets.dart';
import '../base/adaptive_widget.dart';

class AdaptiveElevatedButton extends AdaptiveWidget {
  const AdaptiveElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
