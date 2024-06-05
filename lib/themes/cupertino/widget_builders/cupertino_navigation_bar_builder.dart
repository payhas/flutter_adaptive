import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoNavigationBarBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigationBar> {
  @override
  CupertinoTabBar build(BuildContext context, AdaptiveNavigationBar component) {
    return CupertinoTabBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        onTap: component.onTap,
        currentIndex: component.currentIndex,
        items: component.items
            .map((adaptiveNavigationBarItem) => BottomNavigationBarItem(
                icon: adaptiveNavigationBarItem.icon,
                label: adaptiveNavigationBarItem.label))
            .toList());
  }
}
