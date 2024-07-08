import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

class CupertinoTextButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, AdaptiveTextButton widget) {
    return CupertinoButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
