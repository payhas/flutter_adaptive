import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/base/adaptive_widget.dart';

class AdaptiveTextButton extends AdaptiveWidget {
  const AdaptiveTextButton(
    this.onPressed, {
    super.key,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
