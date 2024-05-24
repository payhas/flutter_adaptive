import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialNavigationBarBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigationBar> {
  @override
  Widget build(BuildContext context, AdaptiveNavigationBar component) {
    return NavigationBar(
        onDestinationSelected: component.onTap,
        selectedIndex: component.currentIndex,
        destinations: component.items
            .map((adaptiveNavigationBarItem) => NavigationDestination(
                icon: adaptiveNavigationBarItem.icon,
                label: adaptiveNavigationBarItem.label ?? ""))
            .toList());
  }
}
