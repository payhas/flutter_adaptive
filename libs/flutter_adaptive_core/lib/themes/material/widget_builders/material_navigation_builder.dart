import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return ResponsiveNavigation(
      groupDestinations: component.groupDestinations,
      showNavigationDrawerOnMobile: component.showNavigationDrawerOnMobile,
      showBottomNavigationBarOnMobile:
          component.showBottomNavigationBarOnMobile,
      showOnlyNavigationRailOnDesktop:
          component.showOnlyNavigationRailOnDesktop,
      showOnlyModalNavigationDrawerOnTablet:
          component.showOnlyModalNavigationDrawerOnTablet,
      showOnlyModalNavigationDrawerOnDesktop:
          component.showOnlyModalNavigationDrawerOnDesktop,
    );
  }
}

class ResponsiveNavigation extends StatelessWidget {
  const ResponsiveNavigation(
      {super.key,
      required this.groupDestinations,
      required this.showNavigationDrawerOnMobile,
      required this.showBottomNavigationBarOnMobile,
      required this.showOnlyModalNavigationDrawerOnDesktop,
      required this.showOnlyNavigationRailOnDesktop,
      required this.showOnlyModalNavigationDrawerOnTablet})
      : assert(showOnlyModalNavigationDrawerOnDesktop == false ||
            showOnlyNavigationRailOnDesktop == false);

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;
  final bool showOnlyModalNavigationDrawerOnDesktop;
  final bool showOnlyNavigationRailOnDesktop;
  final bool showOnlyModalNavigationDrawerOnTablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.tablet) {
          return NavigationMobile(
            groupDestinations: groupDestinations,
            showNavigationDrawerOnMobile: showNavigationDrawerOnMobile,
            showBottomNavigationBarOnMobile: showBottomNavigationBarOnMobile,
          );
        } else if (constraints.maxWidth < FormFactor.desktop) {
          if (showOnlyModalNavigationDrawerOnTablet) {
            return ModalNavigationDrawerMenu(
                groupDestinations: groupDestinations);
          }
          return NavigationRailMenu(groupDestinations: groupDestinations);
        } else {
          if (showOnlyModalNavigationDrawerOnDesktop) {
            return ModalNavigationDrawerMenu(
                groupDestinations: groupDestinations);
          }
          if (showOnlyNavigationRailOnDesktop) {
            return NavigationRailMenu(groupDestinations: groupDestinations);
          }
          return OpenNavigationDrawerMenu(groupDestinations: groupDestinations);
        }
      },
    );
  }
}

class NavigationMobile extends StatelessWidget {
  const NavigationMobile(
      {super.key,
      required this.groupDestinations,
      required this.showNavigationDrawerOnMobile,
      required this.showBottomNavigationBarOnMobile})
      : assert(
            showNavigationDrawerOnMobile == true ||
                showBottomNavigationBarOnMobile == true,
            "Set at least one navigation on mobile");

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;

  @override
  Widget build(BuildContext context) {
    if (showBottomNavigationBarOnMobile == true &&
        showNavigationDrawerOnMobile == true) {
      return BottomWithDrawerNavigationMenu(
          groupDestinations: groupDestinations);
    }

    if (showBottomNavigationBarOnMobile == true) {
      return BottomNavigationBarMenu(groupDestinations: groupDestinations);
    }

    return ModalNavigationDrawerMenu(groupDestinations: groupDestinations);
  }
}

class BottomWithDrawerNavigationMenuScope extends InheritedWidget {
  const BottomWithDrawerNavigationMenuScope(
      {super.key,
      required super.child,
      required this.drawerSelectedIndex,
      required this.groupedDrawer});

  final int drawerSelectedIndex;
  final Widget groupedDrawer;

  @override
  bool updateShouldNotify(BottomWithDrawerNavigationMenuScope oldWidget) {
    return drawerSelectedIndex != oldWidget.drawerSelectedIndex;
  }

  static BottomWithDrawerNavigationMenuScope of(BuildContext context) {
    final BottomWithDrawerNavigationMenuScope? result =
        context.dependOnInheritedWidgetOfExactType<
            BottomWithDrawerNavigationMenuScope>();
    assert(result != null,
        'No BottomWithDrawerNavigationMenuScope found in context');
    return result!;
  }

  static BottomWithDrawerNavigationMenuScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        BottomWithDrawerNavigationMenuScope>();
  }
}

class BottomWithDrawerNavigationMenu extends StatefulWidget {
  BottomWithDrawerNavigationMenu({super.key, required this.groupDestinations})
      : assert(
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
                  .where((destination) =>
                      destination.showOnDrawerWhenBottomWithDrawer == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerWhenBottomWithDrawer = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  BottomWithDrawerNavigationMenuState createState() =>
      BottomWithDrawerNavigationMenuState();
}

class BottomWithDrawerNavigationMenuState
    extends State<BottomWithDrawerNavigationMenu> {
  int _bottomAppBarSelectedIndex = 0;

  void _bottomAppBarOnItemTapped(int index) {
    setState(() {
      _bottomAppBarSelectedIndex = index;
    });
  }

  int _drawerSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var drawerGroupDestinations =
        drawerWhenBottomWithDrawerGroupDestinations(widget.groupDestinations);

    var drawerDestinations =
        drawerGroupDestinations.expand((group) => group.destinations).toList();

    var bottomAppBarDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnBottomAppBar == true)
        .toList();

    Widget groupedDrawer() {
      return GroupedNavigationDrawer(
          groupDestinations: drawerGroupDestinations,
          onDestinationSelected: (index) {
            setState(() {
              _drawerSelectedIndex = index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          drawerDestinations[_drawerSelectedIndex].page));
            });
          },
          selectedIndex: _drawerSelectedIndex);
    }

    return BottomWithDrawerNavigationMenuScope(
      drawerSelectedIndex: _drawerSelectedIndex,
      groupedDrawer: groupedDrawer(),
      child: Scaffold(
        drawer: groupedDrawer(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _bottomAppBarSelectedIndex,
          onDestinationSelected: _bottomAppBarOnItemTapped,
          destinations: bottomAppBarDestinations
              .map((destination) => NavigationDestination(
                    icon: destination.icon,
                    label: destination.label,
                  ))
              .toList(),
        ),
        body: bottomAppBarDestinations[_bottomAppBarSelectedIndex].page,
      ),
    );
  }
}

class BottomNavigationBarMenu extends StatefulWidget {
  BottomNavigationBarMenu({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnBottomAppBar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnBottomAppBar = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  BottomNavigationBarMenuState createState() => BottomNavigationBarMenuState();
}

class BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var bottomAppBarDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnBottomAppBar == true)
        .toList();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: bottomAppBarDestinations
            .map((destination) => NavigationDestination(
                  icon: destination.icon,
                  label: destination.label,
                ))
            .toList(),
      ),
      body: bottomAppBarDestinations[_selectedIndex].page,
    );
  }
}

class NavigationRailMenu extends StatefulWidget {
  NavigationRailMenu({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnNavigationRail == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnNavigationRail = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

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
    var railDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnNavigationRail == true)
        .toList();

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: railDestinations
                .map((destination) => NavigationRailDestination(
                      icon: destination.icon,
                      label: Text(destination.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: railDestinations[_selectedIndex].page,
          ),
        ],
      ),
    );
  }
}

class ModalNavigationDrawerMenuScope extends InheritedWidget {
  const ModalNavigationDrawerMenuScope(
      {super.key,
      required super.child,
      required this.drawerSelectedIndex,
      required this.groupedDrawer});

  final int drawerSelectedIndex;
  final Widget groupedDrawer;

  @override
  bool updateShouldNotify(ModalNavigationDrawerMenuScope oldWidget) {
    return drawerSelectedIndex != oldWidget.drawerSelectedIndex;
  }

  static ModalNavigationDrawerMenuScope of(BuildContext context) {
    final ModalNavigationDrawerMenuScope? result = context
        .dependOnInheritedWidgetOfExactType<ModalNavigationDrawerMenuScope>();
    assert(
        result != null, 'No ModalNavigationDrawerMenuScope found in context');
    return result!;
  }

  static ModalNavigationDrawerMenuScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ModalNavigationDrawerMenuScope>();
  }
}

class ModalNavigationDrawerMenu extends StatefulWidget {
  ModalNavigationDrawerMenu({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnDrawerSidebar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  ModalNavigationDrawerMenuState createState() =>
      ModalNavigationDrawerMenuState();
}

class ModalNavigationDrawerMenuState extends State<ModalNavigationDrawerMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      Navigator.maybePop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    var allDestinations =
        drawerGroupDestinations.expand((group) => group.destinations).toList();

    Widget groupedDrawer() {
      return GroupedNavigationDrawer(
          groupDestinations: drawerGroupDestinations,
          onDestinationSelected: _onItemTapped,
          selectedIndex: _selectedIndex);
    }

    return ModalNavigationDrawerMenuScope(
      drawerSelectedIndex: _selectedIndex,
      groupedDrawer: groupedDrawer(),
      child: allDestinations[_selectedIndex].page,
    );
  }
}

class OpenNavigationDrawerMenu extends StatefulWidget {
  OpenNavigationDrawerMenu({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnDrawerSidebar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  OpenNavigationDrawerMenuState createState() =>
      OpenNavigationDrawerMenuState();
}

class OpenNavigationDrawerMenuState extends State<OpenNavigationDrawerMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    return Scaffold(
      body: Row(
        children: [
          GroupedNavigationDrawer(
              groupDestinations: drawerGroupDestinations,
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex),
          Expanded(
              child: drawerGroupDestinations
                  .expand((group) => group.destinations)
                  .toList()[_selectedIndex]
                  .page),
        ],
      ),
    );
  }
}

class GroupedNavigationDrawer extends StatelessWidget {
  const GroupedNavigationDrawer(
      {super.key,
      this.onDestinationSelected,
      this.selectedIndex,
      required this.groupDestinations});

  final ValueChanged<int>? onDestinationSelected;
  final int? selectedIndex;
  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      children: <Widget>[
        for (int i = 0; i < groupDestinations.length; i++) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              groupDestinations[i].name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...groupDestinations[i].destinations.map((dest) {
            return NavigationDrawerDestination(
                icon: dest.icon, label: Text(dest.label));
          }),
          if (i < groupDestinations.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Divider(),
            ),
          if (i == groupDestinations.length - 1)
            const SizedBox(
              height: 16,
            )
        ],
      ],
    );
  }
}
