import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;
import 'package:yaru/yaru.dart';

class YaruAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  YaruWindowTitleBar build(BuildContext context, AdaptiveAppBar component) {
    LinuxNavigationDrawerMenuState? linuxNavigationDrawerMenuState =
        context.findAncestorStateOfType<LinuxNavigationDrawerMenuState>();

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
          return component.leading!;
        } else {
          if (isPermanent && isModal) {
            return drawerButton();
          }
          if (!isPermanent) {
            return drawerButton();
          }
        }
        return const SizedBox.shrink();
      }),
      title: component.title,
      actions: component.actions?.map((action) {
        return AdaptiveIconButton(
            onPressed: action.onPressed, icon: action.icon);
      }).toList(),
    );
  }
}
