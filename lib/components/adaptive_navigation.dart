import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveNavigation extends AdaptiveWidget {
  const AdaptiveNavigation({
    super.key,
    required this.destinations,
  });

  final List<AdaptiveDestination> destinations;
}

class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}

class AdaptiveDestination {
  const AdaptiveDestination({
    required this.icon,
    required this.label,
    required this.page,
  });

  final Widget icon;
  final String label;
  final Widget page;
}
