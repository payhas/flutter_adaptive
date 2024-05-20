import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialContextMenuItemBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenuItem> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenuItem component) {
    return MenuItemButton(
      onPressed: component.onPressed,
      child: Text(component.text),
    );
  }
}
