import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class YaruTextButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, AdaptiveTextButton widget) {
    return TextButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
