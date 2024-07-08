import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

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
