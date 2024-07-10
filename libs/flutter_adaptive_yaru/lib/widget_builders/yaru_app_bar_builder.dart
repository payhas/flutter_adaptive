import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive_yaru/flutter_adaptive_yaru.dart'
    hide YaruIcons;
import 'master_detail/yaru_landscape_layout.dart';
import 'master_detail/yaru_portrait_layout.dart';

class YaruAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  YaruWindowTitleBar build(BuildContext context, AdaptiveAppBar component) {
    LinuxNavigationDrawerMenuState? linuxNavigationDrawerMenuState =
        context.findAncestorStateOfType<LinuxNavigationDrawerMenuState>();

    YaruPortraitDetailBuilderPage? yaruPortraitDetailBuilderPage =
        context.findAncestorWidgetOfExactType<YaruPortraitDetailBuilderPage>();

    YaruLandscapeDetailBuilderPage? yaruLandscapeDetailBuilderPage =
        context.findAncestorWidgetOfExactType<YaruLandscapeDetailBuilderPage>();

    var scaffoldKey = linuxNavigationDrawerMenuState?.scaffoldKey;

    bool isPermanent =
        linuxNavigationDrawerMenuState?.widget.isPermanent ?? false;
    bool isModal = linuxNavigationDrawerMenuState?.widget.isModal ?? false;

    Widget drawerButton() {
      return IconButton(
          onPressed: () {
            if (scaffoldKey?.currentState?.isDrawerOpen == true) {
              scaffoldKey?.currentState?.closeDrawer();
            } else {
              scaffoldKey?.currentState?.openDrawer();
            }
          },
          icon: const Icon(YaruIcons.pan_start));
    }

    return YaruWindowTitleBar(
      platform: YaruWindowControlPlatform.yaru,
      buttonPadding: const EdgeInsets.all(10.0),
      buttonSpacing: 10.0,
      border: BorderSide.none,
      backgroundColor: Colors.transparent,
      leading: Builder(builder: (context) {
        if (component.leading != null) {
          if (yaruPortraitDetailBuilderPage != null) {
            return const BackButton();
          }
          return component.leading!;
        } else {
          if (yaruPortraitDetailBuilderPage != null) {
            return const BackButton();
          }
          if (isPermanent && isModal) {
            return drawerButton();
          }
          if (!isPermanent && yaruLandscapeDetailBuilderPage == null) {
            return drawerButton();
          }
        }
        return const SizedBox.shrink();
      }),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (component.title != null)
            Expanded(
                child: Align(
                    alignment: Alignment.center, child: component.title!)),
          ...?component.actions?.map((action) {
            return AdaptiveIconButton(
                onPressed: action.onPressed, icon: action.icon);
          }),
        ],
      ),
    );
  }
}
