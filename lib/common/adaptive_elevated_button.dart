import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/base/adaptive_widget.dart';

class AdaptiveElevatedButton extends AdaptiveWidget {
  const AdaptiveElevatedButton(
    this.onPressed, {
    super.key,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
