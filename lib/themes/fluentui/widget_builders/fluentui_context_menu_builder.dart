import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu widget) {
    final contextController = FlyoutController();
    final contextAttachKey = GlobalKey();

    List<MenuFlyoutItem> items = [];
    for (var element in widget.actions) {
      items.add(
          MenuFlyoutItem(text: element.child, onPressed: element.onPressed));
    }
    return GestureDetector(
      onSecondaryTapUp: (d) {
        // This calculates the position of the flyout according to the parent navigator
        final targetContext = contextAttachKey.currentContext;
        if (targetContext == null) return;
        final box = targetContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(
          d.localPosition,
          ancestor: Navigator.of(context).context.findRenderObject(),
        );

        contextController.showFlyout(
          dismissOnPointerMoveAway: true,
          dismissWithEsc: true,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.1),
          position: position,
          builder: (context) {
            return MenuFlyout(
              items: items,
            );
          },
        );
      },
      child: FlyoutTarget(
        key: contextAttachKey,
        controller: contextController,
        child: widget.child,
      ),
    );
  }
}
