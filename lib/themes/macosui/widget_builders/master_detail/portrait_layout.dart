import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/cupertino.dart' hide PageController;
import 'package:flutter_adaptive/layouts/adaptive_master_detail.dart'
    hide MasterTileBuilder;

import 'master_detail_page.dart';
import 'master_list_view.dart';
import 'master_detail_page_controller.dart';

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
  final MasterTileBuilder tileBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final ValueChanged<int>? onSelected;

  final /*ToolBar*/ /*Widget?*/ List<MasterDetailAppBarActionsItem>?
      appBarActions;

  final Widget? appBarTitle;

  final Widget? bottomBar;

  final MacosUIPageController controller;

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

  CupertinoPage page(int index) {
    return CupertinoPage(
      key: ValueKey(index),
      child: Builder(
        builder: (context) => widget.pageBuilder(context, _selectedIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = MacosTheme /*MasterDetailTheme*/ .of(context);
    final toolBar = (widget.appBarActions == null)
        ? null
        : ToolBar(
            title: widget.appBarTitle,
            decoration: BoxDecoration(
              color: MacosTheme.of(context).canvasColor,
            ),
            dividerColor: MacosTheme.of(context).dividerColor,
            actions: [
              for (final item in widget.appBarActions!)
                ToolBarIconButton(
                  label: item.title,
                  icon: item.icon ?? const MacosIcon(CupertinoIcons.app),
                  showLabel: false,
                  onPressed: item.onPressed,
                ),
            ],
          );

    final List<Widget> widgets = [];
    widgets.add(ContentArea(
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) => MasterListView(
            length: widget.controller.length,
            selectedIndex: _selectedIndex,
            onTap: _onTap,
            builder: widget.tileBuilder,
            availableWidth: constraints.maxWidth,
            startUndershoot: widget.appBarActions != null,
            endUndershoot: widget.bottomBar != null,
          ),
        );
      },
    ));

    return PopScope(
      onPopInvoked: (v) async => await _navigator.maybePop(),
      child: MacosTheme(
        data: MacosTheme.of(context).copyWith(
            // pageTransitionsTheme: theme.portraitTransitions,
            ),
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
            CupertinoPage(
              key: const ValueKey(-1),
              child: /*TitleBarTheme(
                data: const TitleBarThemeData(
                  style:
                      kIsWeb ? TitleBarStyle.undecorated : TitleBarStyle.normal,
                ),
                child:*/
                  MacosScaffold(
                // backgroundColor: theme.sideBarColor,
                toolBar: toolBar /*widget.appBar*/,
                children:
                    widgets /*LayoutBuilder(
                    builder: (context, constraints) => MasterListView(
                      length: widget.controller.length,
                      selectedIndex: _selectedIndex,
                      onTap: _onTap,
                      builder: widget.tileBuilder,
                      availableWidth: constraints.maxWidth,
                      startUndershoot: widget.appBar != null,
                      endUndershoot: widget.bottomBar != null,
                    ),
                  )*/
                ,
                // bottomNavigationBar: widget.bottomBar == null
                //     ? null
                //     : Material(
                //         color: theme.sideBarColor,
                //         child: widget.bottomBar,
                //       ),
              ),
              // ),
            ),
            if (_selectedIndex != -1) page(_selectedIndex),
          ],
          observers: [...widget.navigatorObservers, HeroController()],
        ),
      ),
    );
  }
}
