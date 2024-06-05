import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:macos_ui/macos_ui.dart';
// import 'package:flutter/cupertino.dart' show CupertinoIcons;
// import 'package:flutter/widgets.dart';
// import 'package:flutter_adaptive/themes/macosui/widget_builders/master_detail/master_detail_library.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/master_detail/master_detail_library.dart';
// import 'package:flutter_adaptive/themes/fluentui/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MacosApp(
    //   title: 'Master-Detail example',
    //   theme: MacosThemeData(
    //     primaryColor: MacosColors.appleBlue,
    //     // activeColor: Colors.blue,
    //   ),
    //   home: MasterDetailPage(
    //     length: 8,
    //     appBar: const ToolBar(
    //       title: Text('Master'),
    //       // leading: Icon(CupertinoIcons.back),
    //     ),
    //     tileBuilder: (context, index, selected, ___) => MasterTile(
    //       leading: const Icon(CupertinoIcons.add),
    //       title: Text('Master $index'),
    //     ),
    //     pageBuilder: (context, index) => DetailPage(
    //       appBar: ToolBar(
    //         title: Text('Detail $index'),
    //       ),
    //       body: ContentArea(
    //         builder: (context, scrollController) {
    //           return Center(child: Text('Detail $index'));
    //         },
    //       ),
    //     ),
    //   ),
    // );

    return CupertinoApp(
      title: 'Master-Detail example',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        // activeColor: Colors.blue,
      ),
      home: MasterDetailPage(
        length: 8,
        appBar: const CupertinoNavigationBar(
          middle: Text('Master'),
          // leading: Icon(CupertinoIcons.back),
        ),
        tileBuilder: (context, index, selected, ___) => MasterTile(
          leading: const Icon(CupertinoIcons.add),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => DetailPage(
          appBar: CupertinoNavigationBar(
            middle: Text('Detail $index'),
          ),
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );

    // return FluentApp(
    //   title: 'Master-Detail example',
    //   theme: FluentThemeData(
    //     // primaryColor: CupertinoColors.activeBlue,
    //     activeColor: Colors.blue,
    //   ),
    //   home: MasterDetailPage(
    //     length: 8,
    //     appBar: const PageHeader(
    //       title: Text('Master'),
    //       leading: Icon(FluentIcons.back),
    //     ),
    //     tileBuilder: (context, index, selected, ___) => MasterTile(
    //       leading: const Icon(FluentIcons.context_menu),
    //       title: Text('Master $index'),
    //     ),
    //     pageBuilder: (context, index) => DetailPage(
    //       appBar: PageHeader(
    //         title: Text('Detail $index'),
    //       ),
    //       body: Center(child: Text('Detail $index')),
    //     ),
    //   ),
    // );
  }
}
