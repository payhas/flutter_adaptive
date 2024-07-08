import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

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
