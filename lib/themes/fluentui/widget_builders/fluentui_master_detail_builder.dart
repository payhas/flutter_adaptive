import 'package:fluent_ui/fluent_ui.dart' hide PageController;
import 'package:flutter/material.dart' hide PageController;
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/master_detail/master_detail_library.dart';

class FluentUIMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return MasterDetailPage(
      length: 8,
      appBar: const PageHeader(title: Text('Master')),
      tileBuilder: (context, index, selected, ___) => MasterTile(
        leading: const Icon(Icons.menu),
        title: Text('Master $index'),
      ),
      pageBuilder: (context, index) => DetailPage(
        appBar: PageHeader(
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
      controller: component.controller as PageController,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
