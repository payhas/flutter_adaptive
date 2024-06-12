import 'package:flutter/material.dart';
// import 'package:yaru/yaru.dart';
import 'package:flutter_adaptive/themes/yaru/widget_builders/master_detail/master_detail_library.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    show MasterDetailAppBarActionsItem;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Master-Detail example',
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: YaruMasterDetailPage(
        length: 8,
        appBarActions: [
          MasterDetailAppBarActionsItem(
            title: "Settings",
            icon: const Icon(Icons.settings, size: 16.0),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Settings"),
                    content: const Text("Application settings"),
                    actions: [
                      TextButton(
                        child: const Text("Ok"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ]
        /*AppBar(
          title: const Text('Master'),
        )*/
        ,
        tileBuilder: (context, index, selected, ___) => YaruMasterTile(
          leading: const Icon(Icons.menu),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => YaruDetailPage(
          appBarActions: [
            MasterDetailAppBarActionsItem(
              title: "Call",
              icon: const Icon(Icons.phone, size: 24.0),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Call"),
                      content: const Text("Call a friend"),
                      actions: [
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            MasterDetailAppBarActionsItem(
              title: "Video Call",
              icon: const Icon(Icons.video_call, size: 24.0),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("VideoCall"),
                      content: const Text("VideoCall a friend"),
                      actions: [
                        TextButton(
                          child: const Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]
          /*AppBar(
            title: Text('Detail $index'),
          )*/
          ,
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
