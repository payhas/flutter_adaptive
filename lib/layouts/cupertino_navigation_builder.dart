import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    hide CupertinoTheme, CupertinoIcons;

class CupertinoNavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return CupertinoNavigation(destinations: component.destinations);
  }
}

class CupertinoNavigation extends StatefulWidget {
  const CupertinoNavigation({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  CupertinoNavigationState createState() => CupertinoNavigationState();
}

class CupertinoNavigationState extends State<CupertinoNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= FormFactor.tablet) {
          return CupertinoSidebar(
            destinations: widget.destinations,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          );
        } else {
          return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: widget.destinations
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
                  return widget.destinations[index].page;
                },
              );
            },
          );
        }
      },
    );
  }
}

class CupertinoSidebar extends StatefulWidget {
  const CupertinoSidebar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<AdaptiveDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  CupertinoSidebarState createState() => CupertinoSidebarState();
}

class CupertinoSidebarState extends State<CupertinoSidebar>
    with TickerProviderStateMixin {
  bool _isSidebarVisible = true;
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _widthAnimation =
        Tween<double>(begin: 230, end: 0).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _buttonAnimationController.forward();
            } else if (status == AnimationStatus.reverse) {
              _buttonAnimationController.reverse();
            }
          });

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_buttonAnimationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _toggleSidebarVisibility() {
    setState(() {
      if (_isSidebarVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
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
            animation: _widthAnimation,
            builder: (context, child) {
              return Container(
                width: _widthAnimation.value,
                decoration: BoxDecoration(
                  color: brightness == Brightness.light
                      ? CupertinoColors.systemGrey6
                      : CupertinoColors.darkBackgroundGray,
                  boxShadow: [
                    BoxShadow(
                      color: brightness == Brightness.light
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: _widthAnimation.value == 230
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 10.0,
                                  bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    onPressed: _toggleSidebarVisibility,
                                    padding: EdgeInsets.zero,
                                    minSize: 0.0,
                                    child: const Icon(
                                      size: 20.0,
                                      CupertinoIcons.sidebar_left,
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.zero,
                                    minSize: 0.0,
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.fontSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0, bottom: 5.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Photos',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.destinations.length,
                                itemBuilder: (context, index) {
                                  final destination =
                                      widget.destinations[index];

                                  return GestureDetector(
                                    onTap: () => widget.onItemTapped(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: widget.selectedIndex == index
                                            ? CupertinoColors.systemBlue
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7.0,
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                widget.selectedIndex == index
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
                                                      ? widget.selectedIndex ==
                                                              index
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .black
                                                      : CupertinoColors.white,
                                                  fontWeight:
                                                      widget.selectedIndex ==
                                                              index
                                                          ? FontWeight.normal
                                                          : null,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !_isSidebarVisible
                          ? FadeTransition(
                              opacity: _fadeAnimation,
                              child: CupertinoButton(
                                onPressed: _toggleSidebarVisibility,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                minSize: 0.0,
                                child: const Icon(
                                  size: 20.0,
                                  CupertinoIcons.sidebar_left,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {},
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            minSize: 0.0,
                            child: Text(
                              "Aspect",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {},
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            minSize: 0.0,
                            child: Text(
                              "Select",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.fontSize),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: widget.destinations[widget.selectedIndex].page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
