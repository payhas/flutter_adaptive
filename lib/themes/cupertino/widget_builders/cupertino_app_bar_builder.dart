import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide CupertinoIcons;

class CupertinoAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  CupertinoNavigationBar build(BuildContext context, AdaptiveAppBar component) {
    CupertinoSidebarScope? cupertinoSidebarScope =
        CupertinoSidebarScope.maybeOf(context);

    Widget sidebarButton() {
      return CupertinoButton(
        pressedOpacity: 1.0,
        onPressed: cupertinoSidebarScope?.toggleSidebarVisibility,
        padding: const EdgeInsets.only(right: 10.0),
        minSize: 0.0,
        child: const Icon(
          size: 20.0,
          CupertinoIcons.sidebar_left,
        ),
      );
    }

    Widget? leading() {
      if (component.leading != null) {
        return component.leading;
      } else {
        if (cupertinoSidebarScope != null) {
          if (cupertinoSidebarScope.isMobile) {
            return sidebarButton();
          } else if (!cupertinoSidebarScope.isSidebarVisible) {
            return sidebarButton();
          }
        }
      }
      return null;
    }

    return CupertinoNavigationBar(
      leading: leading(),
      middle: component.title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: component.actions?.map((action) {
               return AdaptiveIconButton(
                  onPressed: action.onPressed, icon: action.icon);
            }).toList() ??
            [],
      ),
    );
  }
}
