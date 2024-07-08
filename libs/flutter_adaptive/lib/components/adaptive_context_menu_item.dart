import 'package:flutter/widgets.dart';
import '../base/adaptive_widget.dart';

class AdaptiveContextMenuItem extends AdaptiveWidget {
  const AdaptiveContextMenuItem({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;

  final VoidCallback? onPressed;
}
