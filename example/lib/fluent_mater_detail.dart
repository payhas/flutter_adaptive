import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    show MasterDetailAppBarActionsItem, ResizablePaneDelegate;
import 'package:flutter_adaptive/themes/fluentui/widget_builders/master_detail/master_detail_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Master-Detail example',
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: NavigationView(
        content: Builder(builder: (context) {
          return FluentUIMasterDetailPage(
            paneLayoutDelegate: const ResizablePaneDelegate(
              initialPaneSize: 280,
              minPageSize: kMasterDetailBreakpoint / 2,
              minPaneSize: 175,
            ),
            length: 10,
            appBarTitle: const Text("Master"),
            appBarActions: [
              MasterDetailAppBarActionsItem(
                title: "Settings",
                // icon: const Icon(FluentIcons.settings, size: 16.0),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ContentDialog(
                        title: const Text("Settings"),
                        content: const Text("Application settings"),
                        actions: [
                          Button(
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
            //   return ScaffoldPage(
            //     header: PageHeader(
            //       title: const Text("Master"),
            //       commandBar: CommandBar(
            //         isCompact: true,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         primaryItems: [
            //           CommandBarButton(
            //             icon: const Icon(FluentIcons.settings),
            //             label: const Text("Settings"),
            //             onPressed: () {},
            //           )
            //         ],
            //       ),
            //     ),
            //     content: const SafeArea(
            //       child: Center(
            //         child: Text("Master"),
            //       ),
            //     ),
            //   );
            // },
            tileBuilder: (context, index, selected, ___) {
              switch (index) {
                case 0:
                case 5:
                  return ListTile(
                    leading: const Icon(FluentIcons.home),
                    title: Text('Group $index'),
                  );
                default:
                  return FluentUIMasterTile(
                    leading: const Icon(FluentIcons.context_menu),
                    title: Text('Master $index'),
                  );
              }
            },
            pageBuilder: (ctx, index) {
              return FluentUIDetailPage(
                appBarTitle: const Text("Detail"),
                appBarActions: [
                  MasterDetailAppBarActionsItem(
                    title: "Call",
                    // icon: const Icon(FluentIcons.phone, size: 24.0),
                    onPressed: () {
                      showDialog(
                        context: ctx,
                        builder: (context) {
                          return ContentDialog(
                            title: const Text("Call"),
                            content: const Text("Call a friend"),
                            actions: [
                              Button(
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
                    // icon: const Icon(FluentIcons.camera, size: 24.0),
                    onPressed: () {
                      showDialog(
                        context: ctx,
                        builder: (context) {
                          return ContentDialog(
                            title: const Text("VideoCall"),
                            content: const Text("VideoCall a friend"),
                            actions: [
                              Button(
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
              );
            },
          );
        }),
      ),
    );
  }
}
