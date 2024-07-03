import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide CupertinoIcons;
import 'package:flutter_adaptive/themes/cupertino/widget_builders/master_detail/landscape_layout.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/master_detail/portrait_layout.dart';

import 'master_detail/master_detail_page.dart';

class CupertinoAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  CupertinoNavigationBar build(BuildContext context, AdaptiveAppBar component) {
    CupertinoSidebarScope? cupertinoSidebarScope =
        CupertinoSidebarScope.maybeOf(context);

    CupertinoLandscapeDetailBuilderPage? cupertinoLandscapeDetailBuilderPage =
        context.findAncestorWidgetOfExactType<
            CupertinoLandscapeDetailBuilderPage>();

    CupertinoPortraitDetailBuilderPage? cupertinoPortraitDetailBuilderPage =
        context.findAncestorWidgetOfExactType<
            CupertinoPortraitDetailBuilderPage>();

    CupertinoMasterDetailPage? cupertinoMasterDetailPage =
        context.findAncestorWidgetOfExactType<CupertinoMasterDetailPage>();

    Widget sidebarButton() {
      return CupertinoButton(
        pressedOpacity: 1.0,
        onPressed: cupertinoSidebarScope?.toggleSidebarVisibility,
        padding: const EdgeInsets.only(left: 16),
        minSize: 0.0,
        child: const Icon(
          size: 20.0,
          CupertinoIcons.sidebar_left,
        ),
      );
    }

    Widget? leading() {
      if (component.leading != null) {
        return cupertinoPortraitDetailBuilderPage == null
            ? component.leading
            : null;
      } else {
        if (cupertinoLandscapeDetailBuilderPage != null) {
          return null;
        }
        if (cupertinoPortraitDetailBuilderPage != null) {
          return null;
        }
        if (cupertinoSidebarScope != null) {
          if (cupertinoSidebarScope.isMobile) {
            return sidebarButton();
          } else if (!cupertinoSidebarScope.isSidebarVisible) {
            return sidebarButton();
          }
        } else {
          if (cupertinoMasterDetailPage != null &&
              cupertinoPortraitDetailBuilderPage == null) {
            return CupertinoNavigationBarBackButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).maybePop();
              },
            );
          }
        }
      }
      return null;
    }

    return CupertinoNavigationBar(
      leading: leading(),
      middle: component.title,
      padding: EdgeInsetsDirectional.zero,
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
