import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/master_detail/master_detail_library.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    show MasterDetailAppBarActionsItem;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Master-Detail example',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
      ),
      home: CupertinoMasterDetailPage(
        length: 8,
        appBarActions: [
          MasterDetailAppBarActionsItem(
            title: "Settings",
            icon: const Icon(CupertinoIcons.settings, size: 16.0),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("Settings"),
                    content: const Text("Application settings"),
                    actions: [
                      CupertinoButton(
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
        /*const CupertinoNavigationBar(
          middle: Text('Master'),
        )*/
        ,
        tileBuilder: (context, index, selected, ___) => CupertinoMasterTile(
          leading: const Icon(CupertinoIcons.add),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => CupertinoDetailPage(
          appBarActions: [
            MasterDetailAppBarActionsItem(
              title: "Call",
              icon: const Icon(CupertinoIcons.phone, size: 24.0),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Call"),
                      content: const Text("Call a friend"),
                      actions: [
                        CupertinoButton(
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
              icon: const Icon(CupertinoIcons.video_camera, size: 24.0),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("VideoCall"),
                      content: const Text("VideoCall a friend"),
                      actions: [
                        CupertinoButton(
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
          /*CupertinoNavigationBar(
            middle: Text('Detail $index'),
          )*/
          ,
          body: Center(child: Text('Detail $index')),
        ),
      ),
    );
  }
}
