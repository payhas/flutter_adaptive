import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'master_detail/master_detail_library.dart';
import 'master_detail/portrait_layout.dart';

class MaterialAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  AppBar build(BuildContext context, AdaptiveAppBar component) {
    MaterialMasterDetailPage? materialMasterDetailPage =
        context.findAncestorWidgetOfExactType<MaterialMasterDetailPage>();

    MaterialPortraitDetailBuilderPage? materialPortraitDetailBuilderPage =
        context
            .findAncestorWidgetOfExactType<MaterialPortraitDetailBuilderPage>();

    AdaptiveNavigation? adaptiveNavigation =
        context.findAncestorWidgetOfExactType<AdaptiveNavigation>();

    Widget? leading() {
      if (materialMasterDetailPage != null &&
          materialPortraitDetailBuilderPage == null &&
          adaptiveNavigation == null) {
        return BackButton(onPressed: () {
          Navigator.of(context, rootNavigator: true).maybePop();
        });
      }

      if (materialPortraitDetailBuilderPage != null &&
          component.leading != null) {
        return BackButton(onPressed: () {
          Navigator.of(context).maybePop();
        });
      }

      return component.leading;
    }

    return AppBar(
      leading: leading(),
      title: component.title,
      actions: component.actions?.map((action) {
        return AdaptiveIconButton(
            onPressed: action.onPressed, icon: action.icon);
      }).toList(),
    );
  }
}
