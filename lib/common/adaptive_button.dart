import 'package:flutter/widgets.dart';

import '../base/adaptive_widget.dart';

class AdaptiveButton extends AdaptiveWidget {
  const AdaptiveButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  
  final Widget child;
  final VoidCallback? onPressed;
}
