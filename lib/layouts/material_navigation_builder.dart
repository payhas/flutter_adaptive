import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return ResponsiveNavigation(destinations: component.destinations);
  }
}

class ResponsiveNavigation extends StatelessWidget {
  const ResponsiveNavigation({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.tablet) {
          return NavigationBarMenu(destinations: destinations);
        } else if (constraints.maxWidth < FormFactor.desktop) {
          return NavigationRailMenu(destinations: destinations);
        } else {
          return NavigationDrawerMenu(destinations: destinations);
        }
      },
    );
  }
}

class NavigationBarMenu extends StatefulWidget {
  const NavigationBarMenu({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  NavigationBarMenuState createState() => NavigationBarMenuState();
}

class NavigationBarMenuState extends State<NavigationBarMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.destinations[_selectedIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: widget.destinations
            .map((destination) => NavigationDestination(
                  icon: destination.icon,
                  label: destination.label,
                ))
            .toList(),
      ),
    );
  }
}

class NavigationRailMenu extends StatefulWidget {
  const NavigationRailMenu({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  NavigationRailMenuState createState() => NavigationRailMenuState();
}

class NavigationRailMenuState extends State<NavigationRailMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.selected,
            destinations: widget.destinations
                .map((destination) => NavigationRailDestination(
                      icon: destination.icon,
                      label: Text(destination.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: widget.destinations[_selectedIndex].page,
          ),
        ],
      ),
    );
  }
}

class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  NavigationDrawerMenuState createState() => NavigationDrawerMenuState();
}

class NavigationDrawerMenuState extends State<NavigationDrawerMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: widget.destinations.map((dest) {
                int idx = widget.destinations.indexOf(dest);
                return ListTile(
                  leading: dest.icon,
                  title: Text(dest.label),
                  selected: _selectedIndex == idx,
                  onTap: () => _onItemTapped(idx),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: widget.destinations[_selectedIndex].page,
          ),
        ],
      ),
    );
  }
}
