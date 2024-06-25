import 'dart:math';

import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:provider/provider.dart';
import 'package:yaru/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

const kMasterDetailBreakpoint = 620.0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Adaptive(
      bundles: {
        AdaptiveTheme(),
      },
      builder: (context) => ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, _) => AdaptiveApp(
            theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            home: MasterDetailPage(
                // title: "Master Detail Testing",
                ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _setThemeMaterial() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'Material');
    });
  }

  void _setThemeCupertino() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'Cupertino');
    });
  }

  void _setThemeFluentUI() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'FluentUI');
    });
  }

  void _setThemeYaru() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'Yaru');

      YaruWindowTitleBar.ensureInitialized();
    });
  }

  void _setThemeMacosUI() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'MacosUI');
    });
  }

  void _setThemeLight(ThemeNotifier theme) {
    theme.setLightMode();
  }

  void _setThemeDark(ThemeNotifier theme) {
    theme.setDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              AdaptiveElevatedButton(
                  onPressed: () {
                    var theme = context.read<ThemeNotifier>();
                    _setThemeLight(theme);
                  },
                  child: AdaptiveText("Light")),
              AdaptiveElevatedButton(
                  onPressed: () {
                    var theme = context.read<ThemeNotifier>();
                    _setThemeDark(theme);
                  },
                  child: AdaptiveText("Dark")),
              AdaptiveElevatedButton(
                  onPressed: () => _setThemeMaterial(),
                  child: AdaptiveText("Material")),
              AdaptiveElevatedButton(
                  onPressed: () => _setThemeCupertino(),
                  child: AdaptiveText("Cupertino")),
              AdaptiveElevatedButton(
                  onPressed: () => _setThemeFluentUI(),
                  child: AdaptiveText("FluentUI")),
              AdaptiveElevatedButton(
                  onPressed: () => _setThemeYaru(),
                  child: AdaptiveText("Yaru")),
              AdaptiveElevatedButton(
                  onPressed: () => _setThemeMacosUI(),
                  child: AdaptiveText("MacosUI")),
            ],
          ),
        ),
      ],
    );
  }
}

void displayDialog(BuildContext context, String message) {
  showAdaptiveModalDialog<String>(
    context: context,
    title: const Text("context menu dialog"),
    content: Text("You clicked context menu item '$message'."),
    primaryButton: AdaptiveModalDialogAction(
        onPressed: Navigator.of(context).pop, child: const AdaptiveText("OK")),
  );
}

class ThemeNotifier with ChangeNotifier {
  final lightTheme = const AdaptiveThemeData(
    brightness: Brightness.light,
  );

  final darkTheme = const AdaptiveThemeData(
    brightness: Brightness.dark,
  );

  late AdaptiveThemeData _themeData;

  AdaptiveThemeData getTheme() => _themeData;

  ThemeNotifier() {
    _themeData = lightTheme;
  }

  void setDarkMode() {
    _themeData = darkTheme;
    notifyListeners();
  }

  void setLightMode() {
    _themeData = lightTheme;
    notifyListeners();
  }
}

class MasterDetailPage extends StatelessWidget {
  const MasterDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final length = Random().nextInt(8) + 1;
    final controller = AdaptiveMasterDetailPageController(length: length);

    return AdaptiveMasterDetail(
      paneLayoutDelegate: const ResizablePaneDelegate(
        initialPaneSize: 280,
        minPageSize: kMasterDetailBreakpoint / 2,
        minPaneSize: 175,
        paneSide: PaneSide.end,
      ),
      controller: controller,
      masterBuilder: (context) {
        return AdaptiveScaffold(
          appBar: const AdaptiveAppBar(
            title: AdaptiveText("Master"),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return AdaptiveListTile(
                  title: Text("Master $index"),
                  onTap: () {
                    controller.index = index;
                  },
                );
              },
            ),
          ),
        );
      },
      // length: 8,
      // appBarTitle: const AdaptiveText("Master"),
      // appBarActions: [
      //   MasterDetailAppBarActionsItem(
      //     title: "Settings",
      //     // icon: AdaptiveIcon(AdaptiveIcons.settings),
      //     onPressed: () {
      //       showAdaptiveModalDialog(
      //         context: context,
      //         title: const Text("Settings"),
      //         content: const Text("Application settings"),
      //         primaryButton: AdaptiveModalDialogAction(
      //             onPressed: () => Navigator.pop(context),
      //             child: const AdaptiveText("OK")),
      //       );
      //     },
      //   ),
      // ],
      // tileBuilder: (context, index, selected, availableWidth) =>
      //     AdaptiveMasterTile(
      //   title: Text("Master $index"),
      // ),
      pageBuilder: (ctx, index) {
        return AdaptiveDetailPage(
          appBarTitle: AdaptiveText("Detail $index"),
          appBarActions: [
            MasterDetailAppBarActionsItem(
              title: "Call",
              icon: const AdaptiveIcon(
                AdaptiveIcons.phone,
              ),
              onPressed: () {
                showAdaptiveModalDialog<void>(
                  context: context,
                  title: const Text("Call"),
                  content: const Text("Call a friend"),
                  primaryButton: AdaptiveModalDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: const AdaptiveText("OK")),
                );
              },
            ),
            MasterDetailAppBarActionsItem(
              title: "Video Call",
              icon: const AdaptiveIcon(AdaptiveIcons.videocam),
              onPressed: () {
                showAdaptiveModalDialog(
                  context: context,
                  title: const Text("VideoCall"),
                  content: const Text("VideoCall a friend"),
                  primaryButton: AdaptiveModalDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: const AdaptiveText("OK")),
                );
              },
            ),
          ],
          body: const MyHomePage(title: "Detail"),
        );
        // return MyHomePage(title: "Detail");
      },
    );
  }
}