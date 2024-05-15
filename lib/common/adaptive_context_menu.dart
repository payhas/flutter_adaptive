import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveContextMenu extends AdaptiveWidget {
  const AdaptiveContextMenu({
    super.key,
    required this.child,
    required this.actions,
  });

  final Widget child;

  final List<AdaptiveContextMenuItem> actions;
}