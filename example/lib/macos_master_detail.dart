import 'package:flutter_adaptive/layouts/adaptive_master_detail.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter_adaptive/themes/macosui/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      debugShowCheckedModeBanner: false,
      title: 'Master-Detail example',
      theme: MacosThemeData(
        primaryColor: MacosColors.appleBlue,
        brightness: Brightness.light,
      ),
      home: MacosUIMasterDetailPage(
        length: 8,
        appBarActions: [
          MasterDetailAppBarActionsItem(
            title: "Settings",
            icon: const Icon(CupertinoIcons.settings, size: 16.0),
            onPressed: () {
              showMacosAlertDialog(
                context: context,
                builder: (ctx) {
                  return MacosAlertDialog(
                    appIcon: const MacosIcon(CupertinoIcons.phone),
                    title: const Text("Settings"),
                    message: const Text("Application settings"),
                    primaryButton: PushButton(
                      controlSize: ControlSize.large,
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Ok"),
                    ),
                  );
                },
              );
            },
          ),
        ]
        /*ToolBar(
          title: const Text('Master'),
        )*/
        ,
        tileBuilder: (context, index, selected, ___) => MacosUIMasterTile(
          leading: const Icon(CupertinoIcons.add),
          title: Text('Master $index'),
        ),
        pageBuilder: (context, index) => MacosUIDetailPage(
          appBarTitle: Text('Detail $index'),
          appBarActions: [
            MasterDetailAppBarActionsItem(
              title: "Call",
              icon: const Icon(CupertinoIcons.phone, size: 24.0),
              onPressed: () {
                showMacosAlertDialog(
                  context: context,
                  builder: (context) {
                    return MacosAlertDialog(
                      appIcon: const MacosIcon(CupertinoIcons.phone),
                      title: const Text("Calling"),
                      message: const Text("Calling a friend"),
                      primaryButton: PushButton(
                        controlSize: ControlSize.large,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Ok"),
                      ),
                    );
                  },
                );
              },
            ),
            MasterDetailAppBarActionsItem(
              title: "Video Call",
              icon: const Icon(CupertinoIcons.camera, size: 24.0),
              onPressed: () {
                showMacosAlertDialog(
                  context: context,
                  builder: (context) {
                    return MacosAlertDialog(
                      appIcon: const MacosIcon(CupertinoIcons.camera),
                      title: const Text("Video Chat"),
                      message: const Text("Video chat with a friend"),
                      primaryButton: PushButton(
                        controlSize: ControlSize.large,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Ok"),
                      ),
                    );
                  },
                );
              },
            ),
          ]
          /*ToolBar(
            title: Text('Detail $index'),
            ],
          )*/
          ,
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
