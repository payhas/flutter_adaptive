import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialElevatedButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveElevatedButton> {
  @override
  Widget build(BuildContext context, AdaptiveElevatedButton widget) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
