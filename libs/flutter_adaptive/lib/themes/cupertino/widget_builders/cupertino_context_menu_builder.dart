import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

class CupertinoContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu widget) {
    return CupertinoContextMenu(
      actions: widget.actions,
      child: widget.child,
    );
  }
}
