import 'package:flutter/material.dart' hide PageController;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

import 'landscape_layout.dart';
import 'portrait_layout.dart';
import 'constants.dart';

const _kDefaultPaneWidth = 280.0;

typedef MasterTileBuilder = Widget Function(
  BuildContext context,
  int index,
  bool selected,
  double availableWidth,
);

typedef AppBarBuilder = PreferredSizeWidget? Function(BuildContext context);

/// A responsive master-detail page.
///
/// [YaruMasterDetailPage] automatically switches between portrait and landscape
/// mode depending on [breakpoint].
///
/// ```dart
/// YaruMasterDetailPage(
///   length: 8,
///   appBar: AppBar(title: const Text('Master')),
///   tileBuilder: (context, index, selected) => YaruMasterTile(
///     leading: const Icon(YaruIcons.menu),
///     title: Text('Master $index'),
///   ),
///   pageBuilder: (context, index) => YaruDetailPage(
///     appBar: AppBar(
///       title: Text('Detail $index'),
///     ),
///     body: Center(child: Text('Detail $index')),
///   ),
/// )
/// ```
///
/// | Portrait | Landscape |
/// |---|---|
/// | ![portrait](https://raw.githubusercontent.com/ubuntu/yaru.dart/main/doc/assets/yaru_master_detail_page-portrait.png) | ![landscape](https://raw.githubusercontent.com/ubuntu/yaru.dart/main/doc/assets/yaru_master_detail_page-landscape.png) |
///
/// See also:
///  * [YaruMasterTile] - provides the recommended layout for [tileBuilder].
///  * [YaruDetailPage] - provides the recommended layout for [pageBuilder].
///  * [YaruMasterDetailTheme] - allows customizing the looks of [YaruMasterDetailPage].
class MaterialMasterDetailPage extends StatefulWidget {
  const MaterialMasterDetailPage({
    super.key,
    this.length,
    this.tileBuilder,
    this.masterBuilder,
    required this.pageBuilder,
    this.emptyBuilder,
    this.paneLayoutDelegate = const FixedPaneDelegate(
      paneSize: _kDefaultPaneWidth,
      paneSide: PaneSide.start,
    ),
    this.breakpoint,
    this.appBarActions,
    this.appBarTitle,
    // this.appBarBuilder,
    this.bottomBar,
    this.initialIndex,
    this.onSelected,
    this.controller,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
  })  : assert(initialIndex == null || controller == null),
        assert((length == null) != (controller == null));

  /// The total number of pages.
  final int? length;

  /// A builder that is called for each page to build its master tile.
  ///
  /// See also:
  ///  * [YaruMasterTile]
  final MasterTileBuilder? tileBuilder;

  final WidgetBuilder? masterBuilder;

  /// A builder that is called for each page to build its detail page.
  ///
  /// See also:
  ///  * [YaruDetailPage]
  final IndexedWidgetBuilder pageBuilder;

  /// A builder that is called if there are no pages to display.
  final WidgetBuilder? emptyBuilder;

  /// Controls the width, side and resizing capacity of the pane.
  /// [YaruPanedViewLayoutDelegate.paneSide] need to be horizontal (see: [YaruPaneSide.isHorizontal]).
  final PanedViewLayoutDelegate paneLayoutDelegate;

  /// The breakpoint at which `YaruMasterDetailPage` switches between portrait
  /// and landscape layouts.
  ///
  /// Set to `0` to force the landscape layout or `double.infinity` to force the
  /// portrait layout regardless of the page size.
  ///
  /// Defaults to [YaruMasterDetailThemeData.breakpoint].
  final double? breakpoint;

  /// An optional custom AppBar for the left pane.
  ///
  /// See also:
  ///  * [YaruMasterDetailPage.appBarBuilder]
  final /*PreferredSizeWidget?*/ List<MasterDetailAppBarActionsItem>?
      appBarActions;

  final Widget? appBarTitle;

  // /// An optional custom AppBar builder for the master pane.
  // ///
  // /// The builder is called whenever the master-detail layout changes between
  // /// landscape and portrait modes.
  // ///
  // /// See also:
  // ///  * [YaruMasterDetailPage.appBar]
  // final AppBarBuilder? appBarBuilder;

  /// An optional bottom bar for the left pane.
  final Widget? bottomBar;

  /// An optional index of the initial page to show.
  final int? initialIndex;

  /// Called when the user selects a page.
  final ValueChanged<int?>? onSelected;

  /// An optional controller that can be used to navigate to a specific index.
  final AdaptiveMasterDetailPageController /*MaterialPageController*/ ?
      controller;

  /// A key to use when building the [Navigator] widget.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// A list of observers for the [Navigator] widget.
  ///
  /// See also:
  ///  * [Navigator.observers]
  final List<NavigatorObserver> navigatorObservers;

  /// The route name for the initial route.
  ///
  /// See also:
  ///  * [Navigator.initialRoute]
  final String? initialRoute;

  /// Called to generate a route for a given [RouteSettings].
  ///
  /// See also:
  ///  * [Navigator.onGenerateRoute]
  final RouteFactory? onGenerateRoute;

  /// Called when [onGenerateRoute] fails to generate a route.
  ///
  /// See also:
  ///  * [Navigator.onUnknownRoute]
  final RouteFactory? onUnknownRoute;

  /// Returns the orientation of the [YaruMasterDetailPage] that most tightly
  /// encloses the given context.
  static Orientation orientationOf(BuildContext context) {
    return maybeOrientationOf(context)!;
  }

  /// Returns the orientation of the [YaruMasterDetailPage] that most tightly
  /// encloses the given context or `null` if there is no [YaruMasterDetailPage].
  static Orientation? maybeOrientationOf(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_MasterDetailLayoutScope>();
    return scope?.orientation;
  }

  @override
  State<MaterialMasterDetailPage> createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MaterialMasterDetailPage> {
  late /*MaterialPageController*/ AdaptiveMasterDetailPageController
      _controller;
  late final GlobalKey<NavigatorState> _navigatorKey;

  void _updateController() => _controller = widget.controller ??
      AdaptiveMasterDetailPageController /*MaterialPageController*/ (
        length: (widget.masterBuilder != null)
            ? 0
            : widget.length ?? widget.controller!.length,
        initialIndex: widget.initialIndex ?? -1,
      );

  @override
  void initState() {
    super.initState();
    _updateController();
    _navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MaterialMasterDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller ||
        widget.length != oldWidget.length ||
        widget.initialIndex != oldWidget.initialIndex) {
      _updateController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = widget.breakpoint ?? kMasterDetailBreakpoint;
    return Material(
      child: widget.length == 0 || widget.controller?.length == 0
          ? widget.emptyBuilder?.call(context) ?? const SizedBox.shrink()
          : _MasterDetailLayoutBuilder(
              breakpoint: breakpoint,
              portrait: (context) => PortraitLayout(
                navigatorKey: _navigatorKey,
                navigatorObservers: widget.navigatorObservers,
                initialRoute: widget.initialRoute,
                onGenerateRoute: widget.onGenerateRoute,
                onUnknownRoute: widget.onUnknownRoute,
                tileBuilder: widget.tileBuilder,
                masterBuilder: widget.masterBuilder,
                pageBuilder: widget.pageBuilder,
                onSelected: widget.onSelected,
                appBarTitle: widget.appBarTitle,
                appBarActions: widget.appBarActions,
                bottomBar: widget.bottomBar,
                controller: _controller,
              ),
              landscape: (context) => LandscapeLayout(
                navigatorKey: _navigatorKey,
                navigatorObservers: widget.navigatorObservers,
                initialRoute: widget.initialRoute,
                onGenerateRoute: widget.onGenerateRoute,
                onUnknownRoute: widget.onUnknownRoute,
                tileBuilder: widget.tileBuilder,
                masterBuilder: widget.masterBuilder,
                pageBuilder: widget.pageBuilder,
                onSelected: widget.onSelected,
                paneLayoutDelegate: widget.paneLayoutDelegate,
                appBarTitle: widget.appBarTitle,
                appBarActions: widget.appBarActions,
                bottomBar: widget.bottomBar,
                controller: _controller,
              ),
            ),
    );
  }
}

class _MasterDetailLayoutBuilder extends StatelessWidget {
  const _MasterDetailLayoutBuilder({
    required this.breakpoint,
    required this.portrait,
    required this.landscape,
  });

  final double breakpoint;
  final WidgetBuilder portrait;
  final WidgetBuilder landscape;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = constraints.maxWidth < breakpoint
            ? Orientation.portrait
            : Orientation.landscape;
        return _MasterDetailLayoutScope(
          orientation: orientation,
          child: orientation == Orientation.portrait
              ? portrait(context)
              : landscape(context),
        );
      },
    );
  }
}

class _MasterDetailLayoutScope extends InheritedWidget {
  const _MasterDetailLayoutScope({
    required this.orientation,
    required super.child,
  });

  final Orientation orientation;

  @override
  bool updateShouldNotify(_MasterDetailLayoutScope oldWidget) {
    return orientation != oldWidget.orientation;
  }
}
