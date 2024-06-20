import 'package:flutter/material.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/master_detail/master_detail_library.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    show MasterDetailAppBarActionsItem, ResizablePaneDelegate;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Master-Detail example',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: Builder(builder: (context) {
        return MaterialMasterDetailPage(
          paneLayoutDelegate: const ResizablePaneDelegate(
            initialPaneSize: 280,
            minPageSize: kMasterDetailBreakpoint / 2,
            minPaneSize: 175,
          ),
          length: 8,
          appBarTitle: const Text("Master"),
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
          ],
          // masterBuilder: (context) {
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: const Text("MasterBuilder"),
          //       actions: [
          //         IconButton(
          //           icon: const Icon(Icons.settings),
          //           onPressed: () {},
          //         ),
          //       ],
          //     ),
          //     body: const SafeArea(
          //       child: Center(
          //         child: Text("Master"),
          //       ),
          //     ),
          //   );
          // },
          tileBuilder: (context, index, selected, ___) => MaterialMasterTile(
            leading: const Icon(Icons.menu),
            title: Text('Master $index'),
          ),
          pageBuilder: (context, index) => MaterialDetailPage(
            appBarTitle: const Text("Detail"),
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
            ],
            body: Center(child: Text('Detail $index')),
          ),
        );
      }),
    );
  }
}
