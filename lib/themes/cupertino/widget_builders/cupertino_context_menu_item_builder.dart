import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoContextMenuItemBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenuItem> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenuItem widget) {
    return CupertinoContextMenuAction(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}