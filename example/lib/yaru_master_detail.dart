import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart'
    hide YaruMasterDetailPage, YaruMasterTile, YaruDetailPage;
import 'package:flutter_adaptive/themes/yaru/widget_builders/master_detail/master_detail_library.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    show MasterDetailAppBarActionsItem;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (ctx, yaru, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Master-Detail example',
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          themeMode: ThemeMode.light,
          home: Builder(builder: (context) {
            return YaruMasterDetailPage(
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
              tileBuilder: (context, index, selected, ___) => YaruMasterTile(
                leading: const Icon(Icons.menu),
                title: Text('Master $index'),
              ),
              pageBuilder: (context, index) => YaruDetailPage(
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
      },
    );
  }
}
