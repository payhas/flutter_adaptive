import 'package:fluent_ui/fluent_ui.dart' hide PageController;
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/master_detail/master_detail_library.dart';

class FluentUIMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    print("FluentUI Master Detail Builder build function.");

    return FluentUIMasterDetailPage(
      length: component.length,
      appBar: component.appBar,
      tileBuilder: component.tileBuilder,
      pageBuilder: component.pageBuilder,
      emptyBuilder: component.emptyBuilder,
      breakpoint: component.breakpoint,
      appBarBuilder: component.appBarBuilder,
      bottomBar: component.bottomBar,
      initialIndex: component.initialIndex,
      onSelected: component.onSelected,
      controller: component.controller as FluentUIPageController?,
      navigatorKey: component.navigatorKey,
      navigatorObservers: component.navigatorObservers,
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onUnknownRoute: component.onUnknownRoute,
    );
  }
}
