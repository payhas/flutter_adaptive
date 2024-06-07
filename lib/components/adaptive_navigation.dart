import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveNavigation extends AdaptiveWidget {
  AdaptiveNavigation({
    super.key,
    required this.groupDestinations,
  })  : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnBottomAppBar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnBottomAppBar = true',
        ),
        assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnNavigationRail == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnNavigationRail = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;
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
    this.showOnNavigationRail,
    this.showOnBottomAppBar,
  });

  final Widget icon;
  final String label;
  final Widget page;
  final bool? showOnNavigationRail;
  final bool? showOnBottomAppBar;
}

class AdaptiveGroupDestination {
  const AdaptiveGroupDestination({required this.destinations, required this.name});

  final String name;
  final List<AdaptiveDestination> destinations;
}
