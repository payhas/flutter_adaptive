import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

typedef AdaptiveAppBarBuilder = PreferredSizeWidget? Function(
    BuildContext context);

typedef MasterTileBuilder = Widget Function(
  BuildContext context,
  int index,
  bool selected,
  double availableWidth,
);

class AdaptiveMasterDetail extends AdaptiveWidget {
  AdaptiveMasterDetail({
    super.key,
    this.length,
    required this.tileBuilder,
    required this.pageBuilder,
    this.emptyBuilder,
    // this.paneLayoutDelegate = const YaruFixedPaneDelegate(
    //   paneSize: _kDefaultPaneWidth,
    //   paneSide: YaruPaneSide.start,
    // ),
    this.breakpoint,
    this.appBarTitle,
    this.appBarActions,
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
  }) {
    print("AdaptiveMasterDetail Widget  constructor");
  }

  /// The total number of pages.
  final int? length;

  /// A builder that is called for each page to build its master tile.
  ///
  /// See also:
  ///  * [YaruMasterTile]
  final MasterTileBuilder tileBuilder;

  /// A builder that is called for each page to build its detail page.
  ///
  /// See also:
  ///  * [YaruDetailPage]
  final IndexedWidgetBuilder pageBuilder;

  /// A builder that is called if there are no pages to display.
  final WidgetBuilder? emptyBuilder;

  // /// Controls the width, side and resizing capacity of the pane.
  // /// [YaruPanedViewLayoutDelegate.paneSide] need to be horizontal (see: [YaruPaneSide.isHorizontal]).
  // final YaruPanedViewLayoutDelegate paneLayoutDelegate;

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
  final /*PreferredSize*/ /*Widget?*/ List<MasterDetailAppBarActionsItem>?
      appBarActions;

  final Widget? appBarTitle;

  // /// An optional custom AppBar builder for the master pane.
  // ///
  // /// The builder is called whenever the master-detail layout changes between
  // /// landscape and portrait modes.
  // ///
  // /// See also:
  // ///  * [YaruMasterDetailPage.appBar]
  // final AdaptiveAppBarBuilder? appBarBuilder;

  /// An optional bottom bar for the left pane.
  final Widget? bottomBar;

  /// An optional index of the initial page to show.
  final int? initialIndex;

  /// Called when the user selects a page.
  final ValueChanged<int?>? onSelected;

  /// An optional controller that can be used to navigate to a specific index.
  final AdaptiveMasterDetailPageController? controller;

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
}

class AdaptiveMasterDetailPageController extends ChangeNotifier {
  AdaptiveMasterDetailPageController(
      {required this.length, this.initialIndex = -1})
      : _index = initialIndex,
        _previousIndex = initialIndex;
  final int length;
  final int initialIndex;

  int get index => _index;
  int _index;
  set index(int value) => _setIndex(value);

  int get previousIndex => _previousIndex;
  int _previousIndex;

  void _setIndex(value) {
    assert(value < length || length == 0);
    _previousIndex = _index;
    _index = value;
    notifyListeners();
  }
}

class MasterDetailAppBarActionsItem {
  MasterDetailAppBarActionsItem({
    required this.title,
    this.icon,
    this.onPressed,
  });

  String title;
  /*Adaptive*/ Icon? icon;
  VoidCallback? onPressed;
}
