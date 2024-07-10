import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide CupertinoIcons;
import 'package:macos_ui/macos_ui.dart';
import 'master_detail/landscape_layout.dart';
import 'master_detail/portrait_layout.dart';

class MacosUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  ToolBar build(BuildContext context, AdaptiveAppBar component) {
    MacosLandscapeDetailBuilderPage? macosLandscapeDetailBuilderPage = context
        .findAncestorWidgetOfExactType<MacosLandscapeDetailBuilderPage>();

    MacosPortraitDetailBuilderPage? macosPortraitDetailBuilderPage =
        context.findAncestorWidgetOfExactType<MacosPortraitDetailBuilderPage>();

    Widget macosIconButton({IconData? icon, void Function()? onPressed}) {
      return MacosIconButton(
        icon: MacosIcon(
          icon,
          color: MacosTheme.brightnessOf(context).resolve(
            const Color.fromRGBO(0, 0, 0, 0.5),
            const Color.fromRGBO(255, 255, 255, 0.5),
          ),
          size: 20.0,
        ),
        boxConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 20,
          maxWidth: 48,
          maxHeight: 38,
        ),
        onPressed: onPressed,
      );
    }

    Widget sidebarButton() {
      return macosIconButton(
        icon: CupertinoIcons.sidebar_left,
        onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
      );
    }

    Widget? leading() {
      if (component.leading != null) {
        if (component.leading is AdaptiveIconButton) {
          AdaptiveIconButton? action = component.leading as AdaptiveIconButton?;

          Icon icon = const Icon(Icons.report_gmailerrorred);

          if (action?.icon is AdaptiveComponent) {
            AdaptiveComponent adaptiveComponent =
                action?.icon as AdaptiveComponent;

            dynamic adaptiveIcon = adaptiveComponent.build(context);

            if (adaptiveIcon is Icon) {
              icon = adaptiveIcon;
            }
          }

          if (action?.icon is Icon) {
            icon = action?.icon as Icon;
          }

          return macosPortraitDetailBuilderPage == null
              ? macosIconButton(icon: icon.icon, onPressed: action?.onPressed)
              : null;
        }

        return macosPortraitDetailBuilderPage == null
            ? component.leading
            : null;
      } else {
        if (macosLandscapeDetailBuilderPage != null ||
            macosPortraitDetailBuilderPage != null) {
          return null;
        }

        return sidebarButton();
      }
    }

    return ToolBar(
      title: component.title,
      titleWidth: 150.0,
      leading: leading(),
      actions: component.actions?.map((action) {
        String? label;
        if (action.label is AdaptiveText) {
          AdaptiveText text = action.label as AdaptiveText;
          label = text.data;
        }
        if (action.label is Text) {
          Text text = action.label as Text;
          label = text.data;
        }

        Icon icon = const Icon(Icons.report_gmailerrorred);

        if (action.icon is AdaptiveComponent) {
          AdaptiveComponent adaptiveComponent =
              action.icon as AdaptiveComponent;

          dynamic adaptiveIcon = adaptiveComponent.build(context);

          if (adaptiveIcon is Icon) {
            icon = adaptiveIcon;
          }
        }

        if (action.icon is Icon) {
          icon = action.icon as Icon;
        }

        return ToolBarIconButton(
            onPressed: action.onPressed,
            label: label ?? "",
            icon: MacosIcon(icon.icon),
            showLabel: label != null ? true : false);
      }).toList(),
    );
  }
}
