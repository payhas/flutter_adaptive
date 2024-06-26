import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide CupertinoIcons;
import 'package:macos_ui/macos_ui.dart';

class MacosUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  ToolBar build(BuildContext context, AdaptiveAppBar component) {
    return ToolBar(
      title: component.title,
      titleWidth: 150.0,
      leading: MacosIconButton(
        icon: MacosIcon(
          CupertinoIcons.sidebar_left,
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
        onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
      ),
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
