import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide PageController;
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/master_detail/master_detail_library.dart';

class MaterialMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return MaterialMasterDetailPage(
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
      controller: component.controller as MaterialPageController,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
