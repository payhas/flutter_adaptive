import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

typedef ContextMenuBuilder = Widget Function(
    BuildContext context, Offset offset);

class YaruContextMenuBuilder
    extends AdaptiveWidgetBuilder<AdaptiveContextMenu> {
  @override
  Widget build(BuildContext context, AdaptiveContextMenu component) {
    return _ContextMenuRegion(
      contextMenuBuilder: (BuildContext context, Offset offset) {
        return DesktopTextSelectionToolbar(anchor: offset, children: [
          for (int i = 0; i < component.actions.length; i++) ...[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(2.5),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ContextMenuController.removeAny();
                    component.actions[i].onPressed?.call();
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: component.actions[i].child,
                      )),
                ),
              ),
            ),
            if (i + 1 < component.actions.length)
              const Divider(
                indent: 15.0,
                endIndent: 15.0,
                color: Color.fromARGB(255, 235, 235, 235),
              ),
          ]
        ]);
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
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (BuildContext context) {
        return widget.contextMenuBuilder(context, position);
      },
    );
  }

  void _hide() {
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
