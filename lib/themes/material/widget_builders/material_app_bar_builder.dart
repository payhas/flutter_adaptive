import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  AppBar build(BuildContext context, AdaptiveAppBar component) {
    return AppBar(
      leading: component.leading,
      title: component.title,
      actions: component.actions?.map((action) {
        return AdaptiveIconButton(
            onPressed: action.onPressed, icon: action.icon);
      }).toList(),
    );
  }
}
