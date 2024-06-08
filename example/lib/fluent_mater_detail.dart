import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Master-Detail example',
      theme: FluentThemeData.dark(),
      home: FluentUIMasterDetailPage(
        length: 8,
        appBar: const PageHeader(
          title: Text('Master'),
        ),
        tileBuilder: (context, index, selected, ___) => FluentUIMasterTile(
          leading: const Icon(FluentIcons.context_menu),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => FluentUIDetailPage(
          appBar: PageHeader(
            title: Text('Detail $index'),
          ),
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
