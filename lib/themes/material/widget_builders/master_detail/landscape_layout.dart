import 'dart:math';

import 'package:flutter/material.dart' hide PageController;

import 'master_list_view.dart';
import 'paned_view_layout_delegate.dart';
import 'paned_view.dart';
import 'master_detail_page_controller.dart';
import 'master_detail_page.dart';
import 'master_detail_theme.dart';
import 'title_bar_theme.dart';

const kYaruTitleBarHeight = 46.0;

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
    super.key,
    required this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    required this.tileBuilder,
    required this.pageBuilder,
    this.onSelected,
    required this.paneLayoutDelegate,
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
  final PanedViewLayoutDelegate paneLayoutDelegate;
  final Widget? appBar;
  final Widget? bottomBar;
  final PageController controller;

  @override
  State<LandscapeLayout> createState() => _LandscapeLayoutState();
}

class _LandscapeLayoutState extends State<LandscapeLayout> {
  late int _selectedIndex;
  double? _paneWidth;

  @override
  void initState() {
    super.initState();
    assert(widget.paneLayoutDelegate.paneSide.isHorizontal);
    widget.controller.addListener(_controllerCallback);
    _selectedIndex = max(widget.controller.index, 0);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerCallback);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LandscapeLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_controllerCallback);
      widget.controller.addListener(_controllerCallback);
      _selectedIndex = max(widget.controller.index, 0);
    }
  }

  void _controllerCallback() {
    if (widget.controller.index != _selectedIndex) {
      setState(() => _selectedIndex = max(widget.controller.index, 0));
    }
  }

  void _onTap(int index) {
    widget.controller.index = index;
    widget.onSelected?.call(_selectedIndex);
    widget.navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final theme = MasterDetailTheme.of(context);
    return PanedView(
      pane: _buildLeftPane(theme),
      page: _buildPage(context),
      layoutDelegate: widget.paneLayoutDelegate,
      includeSeparator: theme.includeSeparator ?? true,
      onPaneSizeChange: (size) => _paneWidth = size,
    );
  }

  Widget _buildLeftPane(MasterDetailThemeData theme) {
    return Builder(
      builder: (context) {
        return TitleBarTheme(
          data: const TitleBarThemeData(
            style: TitleBarStyle.undecorated,
          ),
          child: Column(
            children: [
              if (widget.appBar != null)
                SizedBox(
                  height: kYaruTitleBarHeight,
                  child: widget.appBar!,
                ),
              Expanded(
                child: Container(
                  color: theme.sideBarColor,
                  child: MasterListView(
                    length: widget.controller.length,
                    selectedIndex: _selectedIndex,
                    onTap: _onTap,
                    builder: widget.tileBuilder,
                    availableWidth: _paneWidth!,
                    startUndershoot: widget.appBar != null,
                    endUndershoot: widget.bottomBar != null,
                  ),
                ),
              ),
              if (widget.bottomBar != null)
                Material(
                  color: theme.sideBarColor,
                  child: widget.bottomBar,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    final theme = MasterDetailTheme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        pageTransitionsTheme: theme.landscapeTransitions,
      ),
      child: ScaffoldMessenger(
        child: Navigator(
          key: widget.navigatorKey,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onUnknownRoute: widget.onUnknownRoute,
          pages: [
            MaterialPage(
              key: ValueKey(_selectedIndex),
              child: Builder(
                builder: (context) => widget.controller.length > _selectedIndex
                    ? widget.pageBuilder(context, _selectedIndex)
                    : widget.pageBuilder(context, 0),
              ),
            ),
          ],
          onPopPage: (route, result) => route.didPop(result),
          observers: [...widget.navigatorObservers, HeroController()],
        ),
      ),
    );
  }
}
