import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

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
