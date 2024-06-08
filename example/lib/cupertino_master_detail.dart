import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Master-Detail example',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
      ),
      home: CupertinoMasterDetailPage(
        length: 8,
        appBar: const CupertinoNavigationBar(
          middle: Text('Master'),
        ),
        tileBuilder: (context, index, selected, ___) => CupertinoMasterTile(
          leading: const Icon(CupertinoIcons.add),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => CupertinoDetailPage(
          appBar: CupertinoNavigationBar(
            middle: Text('Detail $index'),
          ),
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
