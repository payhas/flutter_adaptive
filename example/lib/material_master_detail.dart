import 'package:flutter/material.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master-Detail example',
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MaterialMasterDetailPage(
        length: 8,
        appBar: AppBar(
          title: const Text('Master'),
        ),
        tileBuilder: (context, index, selected, ___) => MaterialMasterTile(
          leading: const Icon(Icons.menu),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => MaterialDetailPage(
          appBar: AppBar(
            title: Text('Detail $index'),
          ),
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
