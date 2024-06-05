import 'package:flutter/foundation.dart';
import 'package:fluent_ui/fluent_ui.dart' hide PageController;
import 'package:flutter/material.dart' show MaterialPage, Material;

import 'master_detail_page.dart';
import 'master_detail_theme.dart';
import 'master_list_view.dart';
import 'master_detail_page_controller.dart';
import 'title_bar_theme.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({
    super.key,
    required this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    required this.tileBuilder,
    required this.pageBuilder,
    this.onSelected,
    this.appBar,
    this.bottomBar,
    required this.controller,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final MasterTileBuilder tileBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final ValueChanged<int>? onSelected;

  final /*PreferredSize*/ Widget? appBar;
  final Widget? bottomBar;

  final PageController controller;

  @override
  State<PortraitLayout> createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  late int _selectedIndex;

  NavigatorState get _navigator => widget.navigatorKey.currentState!;

  @override
  void initState() {
    widget.controller.addListener(_controllerCallback);
    _selectedIndex = widget.controller.index;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerCallback);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PortraitLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_controllerCallback);
      widget.controller.addListener(_controllerCallback);
      _selectedIndex = widget.controller.index;
    }
  }

  void _controllerCallback() {
    if (widget.controller.index != _selectedIndex) {
      setState(() => _selectedIndex = widget.controller.index);
    }
  }

  void _onTap(int index) {
    widget.controller.index = index;
    widget.onSelected?.call(_selectedIndex);
  }

  MaterialPage page(int index) {
    return MaterialPage(
      key: ValueKey(index),
      child: Builder(
        builder: (context) => widget.pageBuilder(context, _selectedIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = MasterDetailTheme.of(context);
    return PopScope(
      onPopInvoked: (v) async => await _navigator.maybePop(),
      child: FluentTheme(
        data: FluentTheme.of(
            context) /*.copyWith(
          pageTransitionsTheme: theme.portraitTransitions,
        )*/
        ,
        child: Navigator(
          key: widget.navigatorKey,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          onPopPage: (route, result) {
            _selectedIndex = -1;
            return route.didPop(result);
          },
          pages: [
            MaterialPage(
              key: const ValueKey(-1),
              child: TitleBarTheme(
                data: const TitleBarThemeData(
                  style:
                      kIsWeb ? TitleBarStyle.undecorated : TitleBarStyle.normal,
                ),
                child: ScaffoldPage(
                  // backgroundColor: theme.sideBarColor,
                  header: widget.appBar,
                  content: LayoutBuilder(
                    builder: (context, constraints) => MasterListView(
                      length: widget.controller.length,
                      selectedIndex: _selectedIndex,
                      onTap: _onTap,
                      builder: widget.tileBuilder,
                      availableWidth: constraints.maxWidth,
                      startUndershoot: widget.appBar != null,
                      endUndershoot: widget.bottomBar != null,
                    ),
                  ),
                  bottomBar: widget.bottomBar == null
                      ? null
                      : Material(
                          color: theme.sideBarColor,
                          child: widget.bottomBar,
                        ),
                ),
              ),
            ),
            if (_selectedIndex != -1) page(_selectedIndex),
          ],
          observers: [...widget.navigatorObservers, HeroController()],
        ),
      ),
    );
  }
}
