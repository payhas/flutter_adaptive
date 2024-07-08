import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveTextButton extends AdaptiveWidget {
  const AdaptiveTextButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
