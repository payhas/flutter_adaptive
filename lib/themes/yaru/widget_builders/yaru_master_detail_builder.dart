import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruIcons;

class YaruMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return YaruMasterDetailPage(
      length: 8,
      appBar: AppBar(title: const Text('Master')),
      tileBuilder: (context, index, ___, selected) => YaruMasterTile(
        leading: const Icon(YaruIcons.menu),
        title: Text('Master $index'),
      ),
      pageBuilder: (context, index) => YaruDetailPage(
        appBar: AppBar(
          title: Text('Detail $index'),
        ),
        body: Center(child: Text('Detail $index')),
      ),
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      appBarBuilder: component.appBarBuilder,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller as YaruPageController,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
