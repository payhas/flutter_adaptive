import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/base/adaptive_widget.dart';

class AdaptiveNavigationBar extends AdaptiveWidget {
  const AdaptiveNavigationBar({
    super.key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
  });

  final List<AdaptiveNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
}

class AdaptiveNavigationBarItem {
  const AdaptiveNavigationBarItem({
    required this.icon,
    this.label,
  });

  final Widget icon;
  final String? label;
}
