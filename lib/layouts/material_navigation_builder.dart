import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return ResponsiveNavigation(
      groupDestinations: component.groupDestinations,
      showNavigationDrawerOnMobile: component.showNavigationDrawerOnMobile,
      showBottomNavigationBarOnMobile:
          component.showBottomNavigationBarOnMobile,
    );
  }
}

class ResponsiveNavigation extends StatelessWidget {
  const ResponsiveNavigation(
      {super.key,
      required this.groupDestinations,
      required this.showNavigationDrawerOnMobile,
      required this.showBottomNavigationBarOnMobile});

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;

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
          return NavigationRailMenu(groupDestinations: groupDestinations);
        } else {
          return OpenNavigationDrawerMenu(
              groupDestinations:
                  drawerSidebarGroupDestinations(groupDestinations));
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

    return ModalNavigationDrawerMenu(
        groupDestinations: drawerSidebarGroupDestinations(groupDestinations));
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
                  .where(
                      (destination) => destination.showOnDrawerSidebar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true',
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
    var allDrawerSidebarGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    var allDrawerSideBarDestinations = allDrawerSidebarGroupDestinations
        .expand((group) => group.destinations)
        .toList();

    var bottomAppBarDestinations = widget.groupDestinations
        .expand((group) => group.destinations)
        .where((destination) => destination.showOnBottomAppBar == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
          title:
              Text(bottomAppBarDestinations[_bottomAppBarSelectedIndex].label)),
      drawer: NavigationDrawer(
        onDestinationSelected: (index) {
          setState(() {
            _drawerSelectedIndex = index;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                            title: Text(allDrawerSideBarDestinations[
                                    _drawerSelectedIndex]
                                .label)),
                        body: allDrawerSideBarDestinations[_drawerSelectedIndex]
                            .page)));
          });
        },
        selectedIndex: _drawerSelectedIndex,
        children: <Widget>[
          for (int i = 0;
              i < allDrawerSidebarGroupDestinations.length;
              i++) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
              child: Text(
                allDrawerSidebarGroupDestinations[i].name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ...allDrawerSidebarGroupDestinations[i].destinations.map((dest) {
              return NavigationDrawerDestination(
                  icon: dest.icon, label: Text(dest.label));
            }),
            if (i < allDrawerSidebarGroupDestinations.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Divider(),
              ),
            if (i == allDrawerSidebarGroupDestinations.length - 1)
              const SizedBox(
                height: 16,
              )
          ],
        ],
      ),
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
            groupAlignment: 0,
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

      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var allDestinations =
        widget.groupDestinations.expand((group) => group.destinations).toList();

    return Scaffold(
      appBar: AppBar(title: Text(allDestinations[_selectedIndex].label)),
      drawer: NavigationDrawer(
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
      body: allDestinations[_selectedIndex].page,
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
                  .page),
        ],
      ),
    );
  }
}
