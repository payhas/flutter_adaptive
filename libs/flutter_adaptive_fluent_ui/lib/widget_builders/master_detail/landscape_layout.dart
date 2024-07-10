import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart' hide PageController;
import 'package:flutter/material.dart'
    hide PageController
    show MaterialPage, Material, Theme;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide MasterTileBuilder, MaterialPage;

import 'master_list_view.dart';
import 'paned_view.dart';
import 'master_detail_page.dart';
import 'constants.dart';

const kYaruTitleBarHeight = 46.0;

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
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
  final MasterTileBuilder? tileBuilder;
  final WidgetBuilder? masterBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final ValueChanged<int>? onSelected;
  final PanedViewLayoutDelegate paneLayoutDelegate;
  final List<MasterDetailAppBarActionsItem>? appBarActions;
  final Widget? appBarTitle;
  final Widget? bottomBar;
  final AdaptiveMasterDetailPageController controller;

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
    final theme = FluentTheme /*MasterDetailTheme*/ .of(context);
    return PanedView(
      pane: _buildLeftPane(theme),
      page: _buildPage(context),
      layoutDelegate: widget.paneLayoutDelegate,
      includeSeparator: /*theme.includeSeparator ??*/ true,
      onPaneSizeChange: (size) => _paneWidth = size,
    );
  }

  Widget _buildLeftPane(FluentThemeData /*MasterDetailThemeData*/ theme) {
    final appBar = widget.appBarActions == null
        ? null
        : PageHeader(
            title: widget.appBarTitle,
            commandBar: CommandBar(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              isCompact: true,
              primaryItems: [
                for (final item in widget.appBarActions!)
                  CommandBarButton(
                    icon: item.icon,
                    label: Text(item.title),
                    onPressed: item.onPressed,
                  )
              ],
            ),
          );

    return Builder(
      builder: (context) {
        return (widget.masterBuilder != null)
            ? widget.masterBuilder!(context)
            : ScaffoldPage(
                header: appBar,
                content: Column(
                  children: [
                    // if (widget.appBarActions != null)
                    //   Container(
                    //     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    //     alignment: Alignment.centerRight,
                    //     color: FluentTheme.of(context).scaffoldBackgroundColor,
                    //     child: SizedBox(
                    //       // height: kYaruTitleBarHeigsht,
                    //       child: appBar,
                    //     ),
                    //   ),
                    Expanded(
                      child: MasterListView(
                        length: widget.controller.length,
                        selectedIndex: _selectedIndex,
                        onTap: _onTap,
                        builder: widget.tileBuilder!,
                        availableWidth: _paneWidth!,
                        startUndershoot: widget.appBarActions != null,
                        endUndershoot: widget.bottomBar != null,
                      ),
                    ),
                    if (widget.bottomBar != null)
                      Material(
                        // color: theme.sideBarColor,
                        child: widget.bottomBar,
                      ),
                  ],
                  // ),
                ),
              );
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    // final theme = MasterDetailTheme.of(context);

    return /*Fluent*/ Theme(
      data: /*Fluent*/ Theme.of(context).copyWith(
        pageTransitionsTheme: kLandscapeLayoutPageTransitionsTheme,
      ),
      child: /*ScaffoldMessenger(
        child:*/
          Navigator(
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
      // ),
    );
  }
}
