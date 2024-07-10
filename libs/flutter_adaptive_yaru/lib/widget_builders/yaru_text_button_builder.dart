import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class YaruTextButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, AdaptiveTextButton widget) {
    return TextButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
