import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu widget) {
    return MenuAnchor(
      builder: (context, controller, child) => GestureDetector(
        onLongPress: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: widget.child,
      ),
      menuChildren: widget.actions,
    );
  }
}
