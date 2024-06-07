import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return ResponsiveNavigation(groupDestinations: component.groupDestinations);
  }
}

class ResponsiveNavigation extends StatelessWidget {
  const ResponsiveNavigation({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.tablet) {
          return NavigationBarMenu(groupDestinations: groupDestinations);
        } else if (constraints.maxWidth < FormFactor.desktop) {
          return NavigationRailMenu(groupDestinations: groupDestinations);
        } else {
          return NavigationDrawerMenu(groupDestinations: groupDestinations);
        }
      },
    );
  }
}

class NavigationBarMenu extends StatefulWidget {
  const NavigationBarMenu({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  NavigationBarMenuState createState() => NavigationBarMenuState();
}

class NavigationBarMenuState extends State<NavigationBarMenu> {
  int _selectedIndex = 0;

  List<AdaptiveDestination> _bottomAppBarDestinations = [];

  @override
  void initState() {
    super.initState();
    _bottomAppBarDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnBottomAppBar == true)
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomAppBarDestinations[_selectedIndex].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: _bottomAppBarDestinations
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
  const NavigationRailMenu({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  NavigationRailMenuState createState() => NavigationRailMenuState();
}

class NavigationRailMenuState extends State<NavigationRailMenu> {
  int _selectedIndex = 0;

  List<AdaptiveDestination> _railDestinations = [];

  @override
  void initState() {
    super.initState();

    _railDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnNavigationRail == true)
        .toList();
  }

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
            groupAlignment: 0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: _railDestinations
                .map((destination) => NavigationRailDestination(
                      icon: destination.icon,
                      label: Text(destination.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _railDestinations[_selectedIndex].page,
          ),
        ],
      ),
    );
  }
}

class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

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
          NavigationDrawer(
            onDestinationSelected: _onItemTapped,
            selectedIndex: _selectedIndex,
            children: <Widget>[
              for (int i = 0; i < widget.groupDestinations.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                  child: Text(
                    widget.groupDestinations[i].name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                ...widget.groupDestinations[i].destinations.map((dest) {
                  return NavigationDrawerDestination(
                      icon: dest.icon, label: Text(dest.label));
                }),
                if (i < widget.groupDestinations.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Divider(),
                  ),
                if (i == widget.groupDestinations.length - 1)
                  const SizedBox(
                    height: 16,
                  )
              ],
            ],
          ),
          Expanded(
              child: widget.groupDestinations
                  .expand((group) => group.destinations)
                  .toList()[_selectedIndex]
                  .page
              //widget.groupDestinations[0].destinations[_selectedIndex].page
              ),
        ],
      ),
    );
  }
}
