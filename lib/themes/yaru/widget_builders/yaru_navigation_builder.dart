import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;

class YaruNavigationBuilder extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return LinuxResponsiveNavigation(
      groupDestinations: component.groupDestinations,
      showOnlyModalNavigationDrawerOnDesktop:
          component.showOnlyModalNavigationDrawerOnDesktop,
    );
  }
}

class LinuxResponsiveNavigation extends StatelessWidget {
  LinuxResponsiveNavigation(
      {super.key,
      required this.groupDestinations,
      required this.showOnlyModalNavigationDrawerOnDesktop})
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
  final bool showOnlyModalNavigationDrawerOnDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.desktop) {
          return LinuxNavigationDrawerMenu(
            groupDestinations: groupDestinations,
            isPermanent: false,
          );
        } else {
          return LinuxNavigationDrawerMenu(
            groupDestinations: groupDestinations,
            isPermanent: true,
            isModal: showOnlyModalNavigationDrawerOnDesktop ? true : false,
          );
        }
      },
    );
  }
}

class LinuxNavigationDrawerMenu extends StatefulWidget {
  const LinuxNavigationDrawerMenu(
      {super.key,
      required this.groupDestinations,
      required this.isPermanent,
      this.isModal = false});

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool isPermanent;
  final bool isModal;

  @override
  LinuxNavigationDrawerMenuState createState() =>
      LinuxNavigationDrawerMenuState();
}

class LinuxNavigationDrawerMenuState extends State<LinuxNavigationDrawerMenu> {
  int _selectedIndex = 0;
  int _selectedGroupIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int groupIndex, int index) {
    setState(() {
      _selectedGroupIndex = groupIndex;
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    window();
  }

  Future<void> window() async {
    await YaruWindowTitleBar.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;

    var drawerGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    Widget yaruDrawer() {
      return Row(
        children: [
          Drawer(
            shape: const RoundedRectangleBorder(),
            backgroundColor: brightness == Brightness.light
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surface,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: drawerGroupDestinations.length,
              itemBuilder: (context, groupIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (groupIndex > 0)
                      const Divider(height: 5.0, indent: 5.0, endIndent: 5.0),
                    ...drawerGroupDestinations[groupIndex]
                        .destinations
                        .asMap()
                        .entries
                        .map((entry) {
                      int destIndex = entry.key;
                      var dest = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            bottom: groupIndex ==
                                        drawerGroupDestinations.length - 1 &&
                                    destIndex ==
                                        drawerGroupDestinations[groupIndex]
                                                .destinations
                                                .length -
                                            1
                                ? 5
                                : 2.5,
                            top: groupIndex == 0 && destIndex == 0 ? 5 : 2.5),
                        child: ListTile(
                          dense: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          selectedColor:
                              Theme.of(context).colorScheme.onSurface,
                          selectedTileColor: Theme.of(context)
                              .hoverColor
                              .copyWith(alpha: 0.09),
                          leading: dest.icon,
                          title: Text(
                            dest.label,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          selected: _selectedGroupIndex == groupIndex &&
                              _selectedIndex == destIndex,
                          onTap: () {
                            if (widget.isModal) Navigator.pop(context);
                            _onItemTapped(groupIndex, destIndex);
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
          VerticalDivider(
            color: brightness == Brightness.light
                ? Colors.grey.withOpacity(0.4)
                : Colors.black26,
          ),
        ],
      );
    }

    if (widget.isPermanent) {
      if (widget.isModal) {
        return Scaffold(
          key: scaffoldKey,
          drawer: yaruDrawer(),
          body: drawerGroupDestinations[_selectedGroupIndex]
              .destinations[_selectedIndex]
              .page,
        );
      } else {
        return Scaffold(
          body: Row(
            children: [
              yaruDrawer(),
              Expanded(
                child: Scaffold(
                  body: drawerGroupDestinations[_selectedGroupIndex]
                      .destinations[_selectedIndex]
                      .page,
                ),
              ),
            ],
          ),
        );
      }
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                shape: const RoundedRectangleBorder(),
                width: constraints.maxWidth,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: drawerGroupDestinations.length,
                  itemBuilder: (context, groupIndex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (groupIndex > 0)
                          const Divider(
                              height: 5.0, indent: 5.0, endIndent: 5.0),
                        ...drawerGroupDestinations[groupIndex]
                            .destinations
                            .asMap()
                            .entries
                            .map((entry) {
                          int destIndex = entry.key;
                          var dest = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                                bottom: groupIndex ==
                                            drawerGroupDestinations.length -
                                                1 &&
                                        destIndex ==
                                            drawerGroupDestinations[groupIndex]
                                                    .destinations
                                                    .length -
                                                1
                                    ? 5
                                    : 2.5,
                                top: groupIndex == 0 && destIndex == 0
                                    ? 5
                                    : 2.5),
                            child: ListTile(
                              dense: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              selectedColor:
                                  Theme.of(context).colorScheme.onSurface,
                              selectedTileColor: Theme.of(context)
                                  .hoverColor
                                  .copyWith(alpha: 0.09),
                              leading: dest.icon,
                              title: Text(
                                dest.label,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              selected: _selectedGroupIndex == groupIndex &&
                                  _selectedIndex == destIndex,
                              onTap: () {
                                Navigator.pop(context); // Close the drawer
                                _onItemTapped(groupIndex, destIndex);
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
              body: drawerGroupDestinations[_selectedGroupIndex]
                  .destinations[_selectedIndex]
                  .page);
        },
      );
    }
  }
}
