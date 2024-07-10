import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoContextMenuItemBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenuItem> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenuItem component) {
    return CupertinoContextMenuAction(
      onPressed: component.onPressed,
      child: Text(component.text),
    );
  }
}
