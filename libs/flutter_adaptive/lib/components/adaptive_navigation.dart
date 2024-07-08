import 'package:flutter/widgets.dart';
import '../flutter_adaptive.dart';

class AdaptiveNavigation extends AdaptiveWidget {
  const AdaptiveNavigation({
    super.key,
    required this.groupDestinations,
    this.showNavigationDrawerOnMobile = false,
    this.showBottomNavigationBarOnMobile = true,
    this.showOnlyModalNavigationDrawerOnDesktop = false,
    this.showOnlyNavigationRailOnDesktop = false,
    this.showOnlyModalNavigationDrawerOnTablet = false,
  });

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;
  final bool showOnlyModalNavigationDrawerOnDesktop;
  final bool showOnlyNavigationRailOnDesktop;
  final bool showOnlyModalNavigationDrawerOnTablet;
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
    this.showOnDrawerSidebar = true,
    this.showOnDrawerWhenBottomWithDrawer = true,
  });

  final Widget icon;
  final String label;
  final AdaptivePage page;
  final bool? showOnNavigationRail;
  final bool? showOnBottomAppBar;
  final bool showOnDrawerSidebar;
  final bool showOnDrawerWhenBottomWithDrawer;
}

class AdaptiveGroupDestination {
  const AdaptiveGroupDestination(
      {required this.destinations, required this.name});

  final String name;
  final List<AdaptiveDestination> destinations;
}

List<AdaptiveGroupDestination> drawerSidebarGroupDestinations(
    List<AdaptiveGroupDestination> groupDestinations) {
  return groupDestinations
      .map((group) {
        List<AdaptiveDestination> filteredDestinations = group.destinations
            .where((destination) => destination.showOnDrawerSidebar)
            .toList();
        return AdaptiveGroupDestination(
            name: group.name, destinations: filteredDestinations);
      })
      .where((group) => group.destinations.isNotEmpty)
      .toList();
}

List<AdaptiveGroupDestination> drawerWhenBottomWithDrawerGroupDestinations(
    List<AdaptiveGroupDestination> groupDestinations) {
  return groupDestinations
      .map((group) {
        List<AdaptiveDestination> filteredDestinations = group.destinations
            .where(
                (destination) => destination.showOnDrawerWhenBottomWithDrawer)
            .toList();
        return AdaptiveGroupDestination(
            name: group.name, destinations: filteredDestinations);
      })
      .where((group) => group.destinations.isNotEmpty)
      .toList();
}
