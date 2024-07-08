import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

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
