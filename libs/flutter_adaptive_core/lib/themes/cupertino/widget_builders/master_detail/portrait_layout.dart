import 'package:flutter/cupertino.dart' hide PageController;
import 'package:flutter_adaptive_core/layouts/adaptive_master_detail.dart'
    hide MasterTileBuilder;

import 'master_detail_page.dart';
import 'master_list_view.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({
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

  final List<MasterDetailAppBarActionsItem>? appBarActions;

  final Widget? appBarTitle;

  final Widget? bottomBar;

  final AdaptiveMasterDetailPageController controller;

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
        builder: (context) => CupertinoPortraitDetailBuilderPage(
            child: widget.pageBuilder(context, _selectedIndex)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navbar = (widget.appBarActions == null)
        ? null
        : CupertinoNavigationBar(
            middle: widget.appBarTitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (final item in widget.appBarActions!)
                  CupertinoButton(
                    onPressed: item.onPressed,
                    child: item.icon ?? const Icon(CupertinoIcons.rectangle),
                  ),
              ],
            ),
          );
    return PopScope(
      onPopInvoked: (v) async => await _navigator.maybePop(),
      child: CupertinoTheme(
        data: CupertinoTheme.of(context),
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
              child: (widget.masterBuilder != null)
                  ? widget.masterBuilder!(context)
                  : CupertinoPageScaffold(
                      navigationBar: navbar,
                      child: SafeArea(
                        child: LayoutBuilder(
                          builder: (context, constraints) => MasterListView(
                            length: widget.controller.length,
                            selectedIndex: _selectedIndex,
                            onTap: _onTap,
                            builder: widget.tileBuilder!,
                            availableWidth: constraints.maxWidth,
                            startUndershoot: widget.appBarActions != null,
                            endUndershoot: widget.bottomBar != null,
                          ),
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

class CupertinoPortraitDetailBuilderPage extends StatelessWidget {
  const CupertinoPortraitDetailBuilderPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
