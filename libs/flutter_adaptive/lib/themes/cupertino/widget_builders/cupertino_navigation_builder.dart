import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart' hide CupertinoTheme, CupertinoIcons;

class CupertinoNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return CupertinoNavigation(
      groupDestinations: component.groupDestinations,
      showNavigationDrawerOnMobile: component.showNavigationDrawerOnMobile,
      showBottomNavigationBarOnMobile:
          component.showBottomNavigationBarOnMobile,
      showOnlyModalNavigationDrawerOnDesktop:
          component.showOnlyModalNavigationDrawerOnDesktop,
      showOnlyModalNavigationDrawerOnTablet:
          component.showOnlyModalNavigationDrawerOnTablet,
    );
  }
}

class CupertinoNavigation extends StatelessWidget {
  const CupertinoNavigation(
      {super.key,
      required this.groupDestinations,
      required this.showNavigationDrawerOnMobile,
      required this.showBottomNavigationBarOnMobile,
      required this.showOnlyModalNavigationDrawerOnDesktop,
      required this.showOnlyModalNavigationDrawerOnTablet});

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showNavigationDrawerOnMobile;
  final bool showBottomNavigationBarOnMobile;
  final bool showOnlyModalNavigationDrawerOnDesktop;
  final bool showOnlyModalNavigationDrawerOnTablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < FormFactor.tablet) {
          return CupertinoMobile(
            groupDestinations: groupDestinations,
            showBottomNavigationBarOnMobile: showBottomNavigationBarOnMobile,
            showNavigationDrawerOnMobile: showNavigationDrawerOnMobile,
          );
        } else if (constraints.maxWidth < FormFactor.desktop) {
          if (showOnlyModalNavigationDrawerOnTablet) {
            return CupertinoSidebar(
                groupDestinations: groupDestinations, isMobile: true);
          }
          return CupertinoSidebar(
              groupDestinations: groupDestinations, isMobile: false);
        } else {
          if (showOnlyModalNavigationDrawerOnDesktop) {
            return CupertinoSidebar(
                groupDestinations: groupDestinations, isMobile: true);
          }
          return CupertinoSidebar(
              groupDestinations: groupDestinations, isMobile: false);
        }
      },
    );
  }
}

class CupertinoMobile extends StatelessWidget {
  const CupertinoMobile(
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
      return BottomWithSideBarMenu(groupDestinations: groupDestinations);
    }

    if (showBottomNavigationBarOnMobile == true) {
      return CupertinoTabBarMenu(groupDestinations: groupDestinations);
    }

    return CupertinoSidebar(
        groupDestinations: groupDestinations, isMobile: true);
  }
}

class CupertinoTabBarMenu extends StatefulWidget {
  final List<AdaptiveGroupDestination> groupDestinations;

  CupertinoTabBarMenu({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnBottomAppBar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnBottomAppBar = true',
        );

  @override
  CupertinoTabBarMenuState createState() {
    return CupertinoTabBarMenuState();
  }
}

class CupertinoTabBarMenuState extends State<CupertinoTabBarMenu> {
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

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottomAppBarDestinations
            .map((destination) => BottomNavigationBarItem(
                  icon: destination.icon,
                  label: destination.label,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return bottomAppBarDestinations[index].page;
          },
        );
      },
    );
  }
}

class CupertinoSidebarScope extends InheritedWidget {
  const CupertinoSidebarScope({
    super.key,
    required super.child,
    required this.isSidebarVisible,
    required this.toggleSidebarVisibility,
    required this.isMobile,
  });

  final bool isSidebarVisible;
  final VoidCallback toggleSidebarVisibility;
  final bool isMobile;

  static CupertinoSidebarScope of(BuildContext context) {
    final CupertinoSidebarScope? result =
        context.dependOnInheritedWidgetOfExactType<CupertinoSidebarScope>();
    assert(result != null, 'No CupertinoSidebarScope found in context');
    return result!;
  }

  static CupertinoSidebarScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CupertinoSidebarScope>();
  }

  void toggleSidebar() {
    toggleSidebarVisibility();
  }

  @override
  bool updateShouldNotify(CupertinoSidebarScope oldWidget) {
    return isSidebarVisible != oldWidget.isSidebarVisible;
  }
}

class CupertinoSidebar extends StatefulWidget {
  CupertinoSidebar({
    super.key,
    required this.groupDestinations,
    required this.isMobile,
    this.width = 230,
    this.sidebarAnimationDuration = 200,
    this.backgroundColor,
    this.shadowColor,
    this.tabScaffold,
    this.selectedTabDestination,
    this.isBottomWithSideBar = false,
  }) : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where((destination) => !isBottomWithSideBar
                      ? destination.showOnDrawerSidebar == true
                      : destination.showOnDrawerWhenBottomWithDrawer == true)
                  .length >=
              2,
          !isBottomWithSideBar
              ? 'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true'
              : 'There must be at least 2 AdaptiveDestinations with showOnDrawerWhenBottomWithDrawer = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool isMobile;
  final double width;
  final int sidebarAnimationDuration;
  final Color? backgroundColor;
  final Color? shadowColor;
  final CupertinoTabScaffold? tabScaffold;
  final AdaptiveDestination? selectedTabDestination;
  final bool isBottomWithSideBar;

  @override
  CupertinoSidebarState createState() => CupertinoSidebarState();
}

class CupertinoSidebarState extends State<CupertinoSidebar>
    with TickerProviderStateMixin {
  late AnimationController sidebarAnimationController;
  late Animation<double> _sidebarWidthAnimation;

  int _selectedIndex = 0;

  bool _isSidebarVisible = true;

  bool _initAnim = false;

  @override
  void initState() {
    super.initState();

    sidebarAnimationController = AnimationController(
      duration: Duration(
          milliseconds: !widget.isMobile ? widget.sidebarAnimationDuration : 0),
      vsync: this,
    );

    _sidebarWidthAnimation = Tween<double>(begin: 0, end: -widget.width)
        .animate(sidebarAnimationController);

    if (widget.isMobile) _toggleSidebarVisibility();
  }

  @override
  void dispose() {
    sidebarAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (widget.isMobile && widget.tabScaffold == null) {
        _toggleSidebarVisibility();
      }

      if (widget.isMobile && widget.tabScaffold != null) {
        var selectedDrawerDestination =
            drawerWhenBottomWithDrawerGroupDestinations(
                    widget.groupDestinations)
                .expand((g) => g.destinations)
                .toList()[index];

        _isSidebarVisible = false;

        Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => selectedDrawerDestination.page))
            .then((_) {
          _isSidebarVisible = true;
        });
      }
    });
  }

  void _toggleSidebarVisibility() {
    setState(() {
      if (_isSidebarVisible) {
        sidebarAnimationController.forward();
      } else {
        sidebarAnimationController.reverse();
      }
      _isSidebarVisible = !_isSidebarVisible;

      if (widget.isMobile && !_initAnim) {
        sidebarAnimationController.duration =
            Duration(milliseconds: widget.sidebarAnimationDuration);
        _initAnim = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = CupertinoTheme.of(context).brightness;

    var sidebarGroupDestinations = !widget.isBottomWithSideBar
        ? drawerSidebarGroupDestinations(widget.groupDestinations)
        : drawerWhenBottomWithDrawerGroupDestinations(widget.groupDestinations);

    var allDestinations =
        sidebarGroupDestinations.expand((g) => g.destinations).toList();

    return CupertinoSidebarScope(
      isSidebarVisible: _isSidebarVisible,
      toggleSidebarVisibility: _toggleSidebarVisibility,
      isMobile: widget.isMobile,
      child: CupertinoPageScaffold(
        child: AnimatedBuilder(
            animation: _sidebarWidthAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  widget.isMobile == false
                      ? Positioned(
                          left: _sidebarWidthAnimation.value + widget.width,
                          top: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: Column(
                            children: [
                              Expanded(
                                child: allDestinations[_selectedIndex].page,
                              ),
                            ],
                          ),
                        )
                      : CupertinoPageScaffold(
                          child: widget.tabScaffold ??
                              allDestinations[_selectedIndex].page),
                  Positioned(
                    left: _sidebarWidthAnimation.value,
                    top: 0.0,
                    bottom: 0.0,
                    child: TapRegion(
                      onTapOutside: (_) {
                        if (_isSidebarVisible && widget.isMobile) {
                          _toggleSidebarVisibility();
                        }
                      },
                      child: Container(
                        width: widget.width,
                        decoration: BoxDecoration(
                          color: widget.backgroundColor ??
                              (brightness == Brightness.light
                                  ? CupertinoColors.systemGrey6
                                  : CupertinoColors.darkBackgroundGray),
                          boxShadow: [
                            BoxShadow(
                              color: widget.shadowColor ??
                                  (brightness == Brightness.light
                                      ? CupertinoColors.systemGrey4
                                      : CupertinoColors.black),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 12.0,
                                    bottom: 10.0),
                                child: CupertinoButton(
                                  pressedOpacity: 1.0,
                                  onPressed: _toggleSidebarVisibility,
                                  padding: EdgeInsets.zero,
                                  minSize: 0.0,
                                  child: const Icon(
                                    size: 20.0,
                                    CupertinoIcons.sidebar_left,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children:
                                      sidebarGroupDestinations.expand((group) {
                                    int groupIndex =
                                        sidebarGroupDestinations.indexOf(group);
                                    List<Widget> groupItems = [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 5.0,
                                            top: groupIndex == 0 ? 0.0 : 10.0),
                                        child: Text(
                                          group.name,
                                          style: TextStyle(
                                            fontSize: groupIndex == 0 ? 24 : 18,
                                            fontWeight: groupIndex == 0
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ];
                                    groupItems.addAll(
                                      group.destinations.map((destination) {
                                        int index = allDestinations
                                            .indexOf(destination);
                                        return GestureDetector(
                                          onTap: () => _onItemTapped(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: _selectedIndex == index
                                                  ? CupertinoColors.systemBlue
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 7.0,
                                              horizontal: 8.0,
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: index ==
                                                        allDestinations.length -
                                                            1
                                                    ? 8.0
                                                    : 0.0),
                                            child: Row(
                                              children: [
                                                ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      _selectedIndex == index
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .systemBlue,
                                                      BlendMode.srcIn),
                                                  child: destination.icon,
                                                ),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                  destination.label,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color: brightness ==
                                                                Brightness.light
                                                            ? _selectedIndex ==
                                                                    index
                                                                ? CupertinoColors
                                                                    .white
                                                                : CupertinoColors
                                                                    .black
                                                            : CupertinoColors
                                                                .white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                    return groupItems;
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class BottomWithSideBarMenu extends StatefulWidget {
  final List<AdaptiveGroupDestination> groupDestinations;

  BottomWithSideBarMenu({super.key, required this.groupDestinations})
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

  @override
  BottomWithSideBarMenuState createState() {
    return BottomWithSideBarMenuState();
  }
}

class BottomWithSideBarMenuState extends State<BottomWithSideBarMenu> {
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

    return CupertinoSidebar(
      groupDestinations: widget.groupDestinations,
      isMobile: true,
      isBottomWithSideBar: true,
      selectedTabDestination: bottomAppBarDestinations[_selectedIndex],
      tabScaffold: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: bottomAppBarDestinations
              .map((destination) => BottomNavigationBarItem(
                    icon: destination.icon,
                    label: destination.label,
                  ))
              .toList(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return bottomAppBarDestinations[index].page;
            },
          );
        },
      ),
    );
  }
}
