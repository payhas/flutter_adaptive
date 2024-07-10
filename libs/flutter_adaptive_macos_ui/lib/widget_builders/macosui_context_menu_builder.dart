import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide CupertinoTheme;

class MacosUIContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu component) {
    return _ContextMenuRegion(
      contextMenuBuilder: (BuildContext context, Offset offset) {
        return TapRegion(
          onTapOutside: (tap) {
            if (kIsWeb) {
              BrowserContextMenu.enableContextMenu();
            }
            ContextMenuController.removeAny();
          },
          child:
              CupertinoDesktopTextSelectionToolbar(anchor: offset, children: [
            for (int i = 0; i < component.actions.length; i++) ...[
              CupertinoDesktopTextSelectionToolbarButton.text(
                onPressed: () {
                  ContextMenuController.removeAny();
                  if (kIsWeb) {
                    BrowserContextMenu.enableContextMenu();
                  }
                  component.actions[i].onPressed?.call();
                },
                text: component.actions[i].text,
              ),
            ]
          ]),
        );
      },
      child: component.child,
    );
  }
}

class _ContextMenuRegion extends StatefulWidget {
  const _ContextMenuRegion({
    required this.child,
    required this.contextMenuBuilder,
  });

  final ContextMenuBuilder contextMenuBuilder;

  final Widget child;

  @override
  State<_ContextMenuRegion> createState() => _ContextMenuRegionState();
}

class _ContextMenuRegionState extends State<_ContextMenuRegion> {
  final ContextMenuController _contextMenuController = ContextMenuController();

  void _onSecondaryTapUp(TapUpDetails details) {
    _show(details.globalPosition);
  }

  void _onTap() {
    if (!_contextMenuController.isShown) {
      return;
    }
    _hide();
  }

  void _show(Offset position) {
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (BuildContext context) {
        return widget.contextMenuBuilder(context, position);
      },
    );
  }

  void _hide() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    _contextMenuController.remove();
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onSecondaryTapUp: _onSecondaryTapUp,
      onTap: _onTap,
      child: widget.child,
    );
  }
}
