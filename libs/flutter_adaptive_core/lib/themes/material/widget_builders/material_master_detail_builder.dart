import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide PageController;
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'master_detail/master_detail_library.dart';

class MaterialMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return MaterialMasterDetailPage(
      length: component.length,
      paneLayoutDelegate: component.paneLayoutDelegate,
      appBarTitle: component.appBarTitle,
      appBarActions: component.appBarActions,
      tileBuilder: component.tileBuilder,
      masterBuilder: component.masterBuilder,
      pageBuilder: component.pageBuilder,
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
