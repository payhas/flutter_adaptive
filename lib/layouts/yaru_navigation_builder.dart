import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;

class YaruNavigationBuilder extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return LinuxResponsiveNavigation(destinations: component.destinations);
  }
}

class LinuxResponsiveNavigation extends StatelessWidget {
  const LinuxResponsiveNavigation({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.desktop) {
          return LinuxNavigationDrawerMenu(
            destinations: destinations,
            isPermanent: false,
          );
        } else {
          return LinuxNavigationDrawerMenu(
            destinations: destinations,
            isPermanent: true,
          );
        }
      },
    );
  }
}

class LinuxNavigationDrawerMenu extends StatefulWidget {
  const LinuxNavigationDrawerMenu(
      {super.key, required this.destinations, required this.isPermanent});

  final List<AdaptiveDestination> destinations;
  final bool isPermanent;

  @override
  LinuxNavigationDrawerMenuState createState() =>
      LinuxNavigationDrawerMenuState();
}

class LinuxNavigationDrawerMenuState extends State<LinuxNavigationDrawerMenu> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openDrawer() {
    setState(() {
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;

    if (widget.isPermanent) {
      return Scaffold(
        body: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: brightness == Brightness.light
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 1,
                    // changes position of shadow
                  ),
                ],
              ),
              child: Drawer(
                shape: const RoundedRectangleBorder(),
                backgroundColor: brightness == Brightness.light
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    YaruWindowTitleBar(
                      leading: const Icon(YaruIcons.search),
                      title: Text(
                        "Settings",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      actions: const [
                        Icon(YaruIcons.menu),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                      isRestorable: false,
                      isClosable: false,
                      isMaximizable: false,
                      isMinimizable: false,
                      backgroundColor: Colors.transparent,
                      border: BorderSide.none,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: widget.destinations.map((dest) {
                          int idx = widget.destinations.indexOf(dest);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.5),
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
                              selected: _selectedIndex == idx,
                              onTap: () => _onItemTapped(idx),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Scaffold(
                  appBar: YaruWindowTitleBar(
                    title: Text(
                      widget.destinations[_selectedIndex].label,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    border: BorderSide.none,
                    backgroundColor: Colors.transparent,
                  ),
                  body: widget.destinations[_selectedIndex].page),
            ),
          ],
        ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              appBar: YaruWindowTitleBar(
                leading: Builder(builder: (context) {
                  if (_scaffoldKey.currentState?.isDrawerOpen == true) {
                    return IconButton(
                        onPressed: _openDrawer,
                        icon: const Icon(YaruIcons.search));
                  }
                  return IconButton(
                      onPressed: _openDrawer,
                      icon: const Icon(YaruIcons.pan_start));
                }),
                title: Text(
                  widget.destinations[_selectedIndex].label,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                border: BorderSide.none,
                backgroundColor: Colors.transparent,
              ),
              body: Scaffold(
                  key: _scaffoldKey,
                  drawer: Drawer(
                    shape: const RoundedRectangleBorder(),
                    width: constraints.maxWidth,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: widget.destinations.map((dest) {
                        int idx = widget.destinations.indexOf(dest);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2.5),
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
                            selected: _selectedIndex == idx,
                            onTap: () {
                              Navigator.pop(context); // Close the drawer
                              _onItemTapped(idx);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  body: widget.destinations[_selectedIndex].page));
        },
      );
    }
  }
}
