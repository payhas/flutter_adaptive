import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoElevatedButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveElevatedButton> {
  @override
  Widget build(BuildContext context, AdaptiveElevatedButton widget) {
    return CupertinoButton.filled(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
