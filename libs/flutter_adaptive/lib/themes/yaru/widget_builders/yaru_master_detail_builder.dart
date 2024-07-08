import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart' hide YaruIcons;
import 'master_detail/master_detail_library.dart';

class YaruMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return YaruMasterDetailPage(
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
