import 'package:flutter_adaptive/flutter_adaptive.dart'
    hide CupertinoTheme, CupertinoIcons;
import 'package:flutter/cupertino.dart' hide PageController;
import 'master_detail/master_detail_library.dart';

class CupertinoMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return CupertinoMasterDetailPage(
      length: component.length,
      appBar: component.appBar as ObstructingPreferredSizeWidget,
      tileBuilder: component.tileBuilder,
      pageBuilder: component.pageBuilder,
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      appBarBuilder: component.appBarBuilder,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller as CupertinoPageController,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
