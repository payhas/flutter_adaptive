import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialContextMenuItemBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenuItem> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenuItem widget) {
    return MenuItemButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
