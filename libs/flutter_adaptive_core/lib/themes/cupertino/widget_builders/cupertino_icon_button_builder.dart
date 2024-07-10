import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoIconButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveIconButton> {
  @override
  Widget build(BuildContext context, AdaptiveIconButton widget) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      child: widget.icon,
    );
  }
}
