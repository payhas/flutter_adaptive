import 'package:flutter_adaptive/flutter_adaptive.dart'
    hide CupertinoTheme, CupertinoIcons;
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons hide PageController;
import 'package:flutter/widgets.dart' hide PageController;
import 'master_detail/master_detail_library.dart';

class MacosUIMasterDetailBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterDetail> {
  @override
  Widget build(BuildContext context, AdaptiveMasterDetail component) {
    return MasterDetailPage(
      length: 8,
      appBar: const ToolBar(title: Text('Master')),
      tileBuilder: (context, index, ___, selected) => MasterTile(
        leading: const Icon(CupertinoIcons.add),
        title: Text('Master $index'),
      ),
      pageBuilder: (context, index) => DetailPage(
        appBar: ToolBar(
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
