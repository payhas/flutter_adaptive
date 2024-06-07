import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    hide CupertinoTheme, CupertinoIcons;

class CupertinoNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return CupertinoNavigation(groupDestinations: component.groupDestinations);
  }
}

class CupertinoNavigation extends StatefulWidget {
  const CupertinoNavigation({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  CupertinoNavigationState createState() => CupertinoNavigationState();
}

class CupertinoNavigationState extends State<CupertinoNavigation> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= FormFactor.tablet) {
          return CupertinoSidebar(
            groupDestinations: widget.groupDestinations,
          );
        } else {
          return CupertinoTabBarMenu(
              groupDestinations: widget.groupDestinations);
        }
      },
    );
  }
}

class CupertinoTabBarMenu extends StatefulWidget {
  final List<AdaptiveGroupDestination> groupDestinations;

  const CupertinoTabBarMenu({super.key, required this.groupDestinations});

  @override
  CupertinoTabBarMenuState createState() {
    return CupertinoTabBarMenuState();
  }
}

class CupertinoTabBarMenuState extends State<CupertinoTabBarMenu> {
  List<AdaptiveDestination> _bottomAppBarDestinations = [];

  int _selectedIndex = 0;

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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomAppBarDestinations
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
            return _bottomAppBarDestinations[index].page;
          },
        );
      },
    );
  }
}

class CupertinoSidebar extends StatefulWidget {
  const CupertinoSidebar({
    super.key,
    required this.groupDestinations,
    this.width = 230,
    this.animationDuration = 150,
    this.backgroundColor,
    this.shadowColor,
  });

  final List<AdaptiveGroupDestination> groupDestinations;
  final double width;
  final int animationDuration;
  final Color? backgroundColor;
  final Color? shadowColor;

  @override
  CupertinoSidebarState createState() => CupertinoSidebarState();
}

class CupertinoSidebarState extends State<CupertinoSidebar>
    with TickerProviderStateMixin {
  bool _isSidebarVisible = true;
  late AnimationController _sidebarAnimationController;
  late AnimationController _sidebarButtonAnimationController;
  late Animation<double> _sidebarWidthAnimation;
  late Animation<double> _sidebarButtonFadeAnimation;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _sidebarAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _sidebarButtonAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _sidebarWidthAnimation = Tween<double>(begin: widget.width, end: 0)
        .animate(_sidebarAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _sidebarButtonAnimationController.forward();
        } else if (status == AnimationStatus.reverse) {
          _sidebarButtonAnimationController.reverse();
        }
      });

    _sidebarButtonFadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(_sidebarButtonAnimationController);
  }

  @override
  void dispose() {
    _sidebarAnimationController.dispose();
    _sidebarButtonAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleSidebarVisibility() {
    setState(() {
      if (_isSidebarVisible) {
        _sidebarAnimationController.forward();
      } else {
        _sidebarAnimationController.reverse();
      }
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = CupertinoTheme.of(context).brightness;

    return CupertinoPageScaffold(
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _sidebarWidthAnimation,
            builder: (context, child) {
              return Container(
                width: _sidebarWidthAnimation.value,
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
                child: _sidebarWidthAnimation.value == widget.width
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 10.0,
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
                                    widget.groupDestinations.expand((group) {
                                  int groupIndex =
                                      widget.groupDestinations.indexOf(group);
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
                                      int index = widget.groupDestinations
                                          .expand((g) => g.destinations)
                                          .toList()
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
                                                      widget.groupDestinations
                                                              .expand((g) => g
                                                                  .destinations)
                                                              .toList()
                                                              .length -
                                                          1
                                                  ? 8.0
                                                  : 0.0),
                                          child: Row(
                                            children: [
                                              ColorFiltered(
                                                colorFilter: ColorFilter.mode(
                                                    _selectedIndex == index
                                                        ? CupertinoColors.white
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
                      )
                    : null,
              );
            },
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: !_isSidebarVisible
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: FadeTransition(
                            opacity: _sidebarButtonFadeAnimation,
                            child: CupertinoButton(
                              pressedOpacity: 1.0,
                              onPressed: _toggleSidebarVisibility,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              minSize: 0.0,
                              child: const Icon(
                                size: 20.0,
                                CupertinoIcons.sidebar_left,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                Expanded(
                  child: widget.groupDestinations
                      .expand((group) => group.destinations)
                      .toList()[_selectedIndex]
                      .page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
