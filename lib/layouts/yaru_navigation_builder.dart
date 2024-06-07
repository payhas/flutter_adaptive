import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;

class YaruNavigationBuilder extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return LinuxResponsiveNavigation(
        groupDestinations: component.groupDestinations);
  }
}

class LinuxResponsiveNavigation extends StatelessWidget {
  const LinuxResponsiveNavigation({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

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
          );
        }
      },
    );
  }
}

class LinuxNavigationDrawerMenu extends StatefulWidget {
  const LinuxNavigationDrawerMenu(
      {super.key, required this.groupDestinations, required this.isPermanent});

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool isPermanent;

  @override
  LinuxNavigationDrawerMenuState createState() =>
      LinuxNavigationDrawerMenuState();
}

class LinuxNavigationDrawerMenuState extends State<LinuxNavigationDrawerMenu> {
  int _selectedIndex = 0;
  int _selectedGroupIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int groupIndex, int index) {
    setState(() {
      _selectedGroupIndex = groupIndex;
      _selectedIndex = index;
    });
  }

  void _openDrawer() {
    setState(() {
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  void _closeDrawer() {
    setState(() {
      _scaffoldKey.currentState?.closeDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;

    if (widget.isPermanent) {
      return Scaffold(
        body: Row(
          children: [
            Drawer(
              shape: const RoundedRectangleBorder(),
              backgroundColor: brightness == Brightness.light
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.surface,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.groupDestinations.length,
                itemBuilder: (context, groupIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (groupIndex > 0)
                        const Divider(height: 5.0, indent: 5.0, endIndent: 5.0),
                      ...widget.groupDestinations[groupIndex].destinations
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
                                          widget.groupDestinations.length - 1 &&
                                      destIndex ==
                                          widget.groupDestinations[groupIndex]
                                                  .destinations.length -
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
                            onTap: () => _onItemTapped(groupIndex, destIndex),
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
            Expanded(
              child: Scaffold(
                appBar: YaruWindowTitleBar(
                  platform: YaruWindowControlPlatform.yaru,
                  buttonPadding: const EdgeInsets.all(10.0),
                  buttonSpacing: 10.0,
                  title: Text(
                    widget.groupDestinations[_selectedGroupIndex]
                        .destinations[_selectedIndex].label,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  border: BorderSide.none,
                  backgroundColor: Colors.transparent,
                ),
                body: widget.groupDestinations[_selectedGroupIndex]
                    .destinations[_selectedIndex].page,
              ),
            ),
          ],
        ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              appBar: YaruWindowTitleBar(
                platform: YaruWindowControlPlatform.yaru,
                buttonPadding: const EdgeInsets.all(10.0),
                buttonSpacing: 10.0,
                leading: IconButton(
                    onPressed: _scaffoldKey.currentState?.isDrawerOpen == true
                        ? _closeDrawer
                        : _openDrawer,
                    icon: const Icon(YaruIcons.pan_start)),
                title: Text(
                  widget.groupDestinations[_selectedGroupIndex]
                      .destinations[_selectedIndex].label,
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
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.groupDestinations.length,
                      itemBuilder: (context, groupIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (groupIndex > 0)
                              const Divider(
                                  height: 5.0, indent: 5.0, endIndent: 5.0),
                            ...widget.groupDestinations[groupIndex].destinations
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
                                                widget.groupDestinations
                                                        .length -
                                                    1 &&
                                            destIndex ==
                                                widget
                                                        .groupDestinations[
                                                            groupIndex]
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  selectedColor:
                                      Theme.of(context).colorScheme.onSurface,
                                  selectedTileColor: Theme.of(context)
                                      .hoverColor
                                      .copyWith(alpha: 0.09),
                                  leading: dest.icon,
                                  title: Text(
                                    dest.label,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                  body: widget.groupDestinations[_selectedGroupIndex]
                      .destinations[_selectedIndex].page));
        },
      );
    }
  }
}
