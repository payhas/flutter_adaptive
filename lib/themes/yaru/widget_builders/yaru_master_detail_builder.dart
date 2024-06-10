import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;

class YaruMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    print("Yaru Master Detail Builder build function.");

    return YaruMasterDetailPage(
      length: component.length,
      appBar: component.appBar as PreferredSizeWidget?,
      tileBuilder: component.tileBuilder,
      pageBuilder: component.pageBuilder,
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      appBarBuilder: component.appBarBuilder,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller as YaruPageController?,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
