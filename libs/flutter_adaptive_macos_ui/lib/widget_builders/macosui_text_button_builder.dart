import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUITextButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, AdaptiveTextButton widget) {
    return CupertinoButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
