import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter_adaptive/themes/macosui/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'Master-Detail example',
      theme: MacosThemeData(
        primaryColor: MacosColors.appleBlue,
        // activeColor: Colors.blue,
      ),
      home: MasterDetailPage(
        length: 8,
        appBar: const ToolBar(
          title: Text('Master'),
          // leading: Icon(CupertinoIcons.back),
        ),
        tileBuilder: (context, index, selected, ___) => MasterTile(
          leading: const Icon(CupertinoIcons.add),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => DetailPage(
          appBar: ToolBar(
            title: Text('Detail $index'),
          ),
          body: ContentArea(
            builder: (context, scrollController) {
              return Center(child: Text('Detail $index'));
            },
          ),
        ),
      ),
    );
  }
}
