import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart' hide YaruMasterTileBuilder;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide MasterTileBuilder, MaterialPage;

import 'yaru_master_list_view.dart';
import 'yaru_paned_view.dart';
import 'yaru_master_detail_page.dart';

class YaruLandscapeLayout extends StatefulWidget {
  const YaruLandscapeLayout({
    super.key,
    required this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.tileBuilder,
    this.masterBuilder,
    required this.pageBuilder,
    this.onSelected,
    required this.paneLayoutDelegate,
    this.appBarActions,
    this.appBarTitle,
    this.bottomBar,
    required this.controller,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final YaruMasterTileBuilder? tileBuilder;
  final WidgetBuilder? masterBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final ValueChanged<int>? onSelected;
  final PanedViewLayoutDelegate paneLayoutDelegate;
  final List<MasterDetailAppBarActionsItem>? appBarActions;
  final Widget? appBarTitle;
  final Widget? bottomBar;
  final AdaptiveMasterDetailPageController controller;

  @override
  State<YaruLandscapeLayout> createState() => _YaruLandscapeLayoutState();
}

class _YaruLandscapeLayoutState extends State<YaruLandscapeLayout> {
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
  void didUpdateWidget(covariant YaruLandscapeLayout oldWidget) {
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
    final theme = YaruMasterDetailTheme.of(context);
    return YaruPanedView(
      pane: _buildLeftPane(theme),
      page: _buildPage(context),
      layoutDelegate: widget.paneLayoutDelegate,
      includeSeparator: theme.includeSeparator ?? true,
      onPaneSizeChange: (size) => _paneWidth = size,
    );
  }

  Widget _buildLeftPane(YaruMasterDetailThemeData theme) {
    final appBar = widget.appBarActions == null
        ? null
        : AppBar(
            title: widget.appBarTitle,
            actions: [
              for (final item in widget.appBarActions!)
                IconButton(
                  onPressed: item.onPressed,
                  icon: item.icon ?? const Icon(Icons.rectangle),
                ),
            ],
          );

    return Builder(
      builder: (context) {
        return YaruTitleBarTheme(
          data: const YaruTitleBarThemeData(
            style: YaruTitleBarStyle.undecorated,
          ),
          child: (widget.masterBuilder != null)
              ? widget.masterBuilder!(context)
              : Scaffold(
                  appBar: appBar,
                  body: Column(
                    children: [
                      // if (widget.appBarActions != null)
                      //   SizedBox(
                      //     height: kYaruTitleBarHeight,
                      //     child: appBar,
                      //   ),
                      Expanded(
                        child: Container(
                          color: theme.sideBarColor,
                          child: YaruMasterListView(
                            length: widget.controller.length,
                            selectedIndex: _selectedIndex,
                            onTap: _onTap,
                            builder: widget.tileBuilder!,
                            availableWidth: _paneWidth!,
                            startUndershoot: widget.appBarActions != null,
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
                ),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    final theme = YaruMasterDetailTheme.of(context);

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
                builder: (context) {
                  return YaruLandscapeDetailBuilderPage(
                      child: widget.controller.length > _selectedIndex
                          ? widget.pageBuilder(context, _selectedIndex)
                          : widget.pageBuilder(context, 0));
                },
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

class YaruLandscapeDetailBuilderPage extends StatelessWidget {
  const YaruLandscapeDetailBuilderPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
