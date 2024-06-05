import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master-Detail example',
      theme: ThemeData(
        primaryColor: Colors.blue,
        // activeColor: Colors.blue,
      ),
      home: YaruMasterDetailPage(
        length: 8,
        appBar: AppBar(
          title: const Text('Master'),
          // leading: Icon(CupertinoIcons.back),
        ),
        tileBuilder: (context, index, selected, ___) => YaruMasterTile(
          leading: const Icon(Icons.menu),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => YaruDetailPage(
          appBar: AppBar(
            title: Text('Detail $index'),
          ),
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
