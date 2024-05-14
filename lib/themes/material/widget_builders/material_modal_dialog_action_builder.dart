import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialModalDialogActionBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialogAction> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialogAction widget) {
    return TextButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
