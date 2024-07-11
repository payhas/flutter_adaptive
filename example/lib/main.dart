import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_fluent_ui/flutter_adaptive_fluent_ui.dart';
import 'package:flutter_adaptive_macos_ui/flutter_adaptive_macos_ui.dart';
import 'package:flutter_adaptive_yaru/flutter_adaptive_yaru.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

String detectPlatform() {
  if (Platform.isIOS) {
    return 'Cupertino';
  }

  if (Platform.isMacOS) {
    return 'MacosUI';
  }

  if (Platform.isWindows) {
    return 'FluentUI';
  }

  if (Platform.isLinux) {
    return 'Yaru';
  }

  return 'Material';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Adaptive(
      bundles: {
        AdaptiveTheme(defaultTheme: detectPlatform()),
        FluentUITheme(),
        MacosUITheme(),
        YaruTheme(),
      },
      builder: (context) => ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, _) {
            Widget bottomBar() {
              return Container(
                color: theme.getTheme().brightness == Brightness.light
                    ? Colors.white
                    : Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    AdaptiveIconButton(
                        onPressed: () {},
                        icon: AdaptiveIcon(AdaptiveIcons.add)),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdaptiveTextInput(placeholder: "Message"),
                    )),
                    AdaptiveIconButton(
                        onPressed: () {},
                        icon: AdaptiveIcon(AdaptiveIcons.send)),
                  ]),
                ),
              );
            }

            return AdaptiveApp(
              theme: theme.getTheme(),
              debugShowCheckedModeBanner: false,
              home: AdaptiveNavigation(
                  showNavigationDrawerOnMobile: true,
                  showBottomNavigationBarOnMobile: true,
                  groupDestinations: <AdaptiveGroupDestination>[
                    AdaptiveGroupDestination(
                        name: "Files",
                        destinations: <AdaptiveDestination>[
                          AdaptiveDestination(
                            showOnDrawerWhenBottomWithDrawer: false,
                            icon: AdaptiveIcon(
                              AdaptiveIcons.home,
                            ),
                            label: 'Home',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(
                                  title: AdaptiveText("Home"),
                                  actions: [
                                    AdaptiveAppBarAction(
                                      onPressed: () {},
                                      label: Text('Bluetooth'),
                                      icon:
                                          AdaptiveIcon(AdaptiveIcons.bluetooth),
                                    ),
                                    AdaptiveAppBarAction(
                                        onPressed: () {},
                                        label: AdaptiveText('Search'),
                                        icon:
                                            AdaptiveIcon(AdaptiveIcons.search)),
                                    AdaptiveAppBarAction(
                                        onPressed: () {},
                                        label: AdaptiveText('Edit'),
                                        icon: AdaptiveIcon(AdaptiveIcons.edit)),
                                  ],
                                ),
                                bottomBar: bottomBar(),
                                child: MyHomePage()),
                            showOnNavigationRail: true,
                            showOnBottomAppBar: true,
                          ),
                          AdaptiveDestination(
                            showOnDrawerWhenBottomWithDrawer: false,
                            icon: AdaptiveIcon(AdaptiveIcons.chat),
                            label: 'Chat',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(
                                  title: Text("Chat"),
                                  actions: [
                                    AdaptiveAppBarAction(
                                        onPressed: () {},
                                        label: AdaptiveText('Search'),
                                        icon:
                                            AdaptiveIcon(AdaptiveIcons.search)),
                                  ],
                                ),
                                child: Center(child: Text('Chat Page'))),
                            showOnNavigationRail: true,
                            showOnBottomAppBar: true,
                          ),
                          AdaptiveDestination(
                            showOnDrawerWhenBottomWithDrawer: false,
                            icon: AdaptiveIcon(AdaptiveIcons.music_note),
                            label: 'Music',
                            page: AdaptivePage(
                                child: Center(child: Text('Music Page'))),
                            showOnNavigationRail: true,
                            showOnBottomAppBar: true,
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.album),
                            label: 'Master-Detail',
                            page: AdaptivePage(
                                child: MasterDetailPage(
                              bottomBar: bottomBar(),
                            )),
                            showOnBottomAppBar: true,
                            showOnNavigationRail: true,
                            showOnDrawerWhenBottomWithDrawer: true,
                          ),
                        ]),
                    AdaptiveGroupDestination(
                        name: "Settings",
                        destinations: <AdaptiveDestination>[
                          AdaptiveDestination(
                            icon: AdaptiveIcon(
                              AdaptiveIcons.edit,
                            ),
                            label: 'Edit',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(
                                  actions: [
                                    AdaptiveAppBarAction(
                                        onPressed: () {},
                                        label: AdaptiveText('Aspect Ratio'),
                                        icon: AdaptiveIcon(
                                            AdaptiveIcons.aspect_ratio)),
                                  ],
                                ),
                                child: Center(child: Text('Edit Page'))),
                            showOnNavigationRail: true,
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.cake),
                            label: 'Cake',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Cake Page'))),
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.book),
                            label: 'Book',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Book Page'))),
                            showOnNavigationRail: true,
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.camera),
                            label: 'Camera',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Camera Page'))),
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.badge),
                            label: 'Badge',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Badge Page'))),
                          ),
                        ]),
                    AdaptiveGroupDestination(
                        name: "Library",
                        destinations: <AdaptiveDestination>[
                          AdaptiveDestination(
                            icon: AdaptiveIcon(
                              AdaptiveIcons.album,
                            ),
                            label: 'Album',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Album Page'))),
                            showOnNavigationRail: true,
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.bluetooth),
                            label: 'Bluetooth',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Bluetooth Page'))),
                            showOnNavigationRail: true,
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.coffee),
                            label: 'Coffee',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Coffee Page'))),
                            showOnNavigationRail: true,
                          ),
                          AdaptiveDestination(
                            icon:
                                AdaptiveIcon(AdaptiveIcons.airplanemode_active),
                            label: 'Airplane',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Airplane Page'))),
                          ),
                        ]),
                    AdaptiveGroupDestination(
                        name: "Search",
                        destinations: <AdaptiveDestination>[
                          AdaptiveDestination(
                            icon: AdaptiveIcon(
                              AdaptiveIcons.cloud,
                            ),
                            label: 'Cloud',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Cloud Page'))),
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.diamond),
                            label: 'Diamond',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Diamond Page'))),
                          ),
                          AdaptiveDestination(
                            icon: AdaptiveIcon(AdaptiveIcons.alarm),
                            label: 'Alarm',
                            page: AdaptivePage(
                                appBar: AdaptiveAppBar(),
                                child: Center(child: Text('Alarm Page'))),
                          ),
                        ]),
                  ]),
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentSliderValue = 0;
  bool isChecked = false;
  DateTime date = DateTime(2016, 10, 26);

  var isSwitchOn = true;

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

  void _setThemeFluentUI() async {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'FluentUI');
    });
  }

  void _setThemeYaru() {
    setState(() {
      ThemedAppearanceManager.setThemeOf(context, 'Yaru');
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
        ExampleWidget(
            name: "Adaptive Icon",
            child: AdaptiveIcon(
              AdaptiveIcons.home,
              color: Colors.green,
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Text",
            child: Expanded(
              child: AdaptiveText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Text Input",
            child: Expanded(
                child: AdaptiveTextInput(
              placeholder: "Border",
            ))),
        const SizedBox(height: 10.0),
        // ExampleWidget(
        //     name: "Adaptive App Bar",
        //     child: AdaptiveAppBar(title: const Text("App Bar Title"))),
        // const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Text Button",
            child: AdaptiveTextButton(
                onPressed: () {}, child: const Text("Adaptive Text Button"))),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Elevated Button",
            child: AdaptiveElevatedButton(
              onPressed: () {},
              child: const Text("Elevated Button"),
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Icon Button",
            child: AdaptiveIconButton(
                onPressed: () {}, icon: const AdaptiveIcon(AdaptiveIcons.add))),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Slider",
            child: AdaptiveSlider(
                value: _currentSliderValue,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                })),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive CheckBox",
            child: AdaptiveCheckbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
          name: "Adaptive Switch",
          child: AdaptiveSwitch(
            value: isSwitchOn,
            onChanged: (value) {
              setState(() {
                isSwitchOn = value;
              });
            },
          ),
        ),
        const SizedBox(height: 20.0),
        ExampleWidget(
            name: "Adaptive Circular Progress Indicator",
            child: AdaptiveCircularProgressIndicator(
              value: null,
            )),
        SizedBox(height: 20.0),
        ExampleWidget(
            name: "Adaptive Linear Progress Indicator",
            child: SizedBox(
              height: 10,
              width: 200,
              child: AdaptiveLinearProgressIndicator(
                value: 56,
              ),
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
          name: "Adaptive Date Picker",
          child: AdaptiveDatePicker(
              initialDate: date,
              minDate: DateTime(1900),
              maxDate: DateTime(2100),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  date = newDate;
                });
              }),
        ),
        const SizedBox(height: 10),
        ExampleWidget(
            name: "Adaptive Modal Dialog",
            child: AdaptiveElevatedButton(
                onPressed: () {
                  showAdaptiveModalDialog<String>(
                    context: context,
                    title: const Text("Simple Dialog"),
                    content: const Text("Adaptive Modal Dialog content"),
                    primaryButton: AdaptiveModalDialogAction(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK')),
                    secondaryButton: AdaptiveModalDialogAction(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel')),
                  );
                },
                child: const Text("Simple Dialog"))),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Modal Bottom Sheet",
            child: AdaptiveElevatedButton(
              onPressed: () {
                showAdaptiveModalBottomSheet<String>(
                  context: context,
                  title: const Text('This is the title'),
                  actions: [
                    AdaptiveBottomSheetAction(
                      title: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: (_) => Navigator.pop(context, 'Add'),
                      leading: const Icon(Icons.add, size: 25),
                    ),
                    AdaptiveBottomSheetAction(
                      title: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: (_) => Navigator.pop(context, 'Delete'),
                      leading: const Icon(
                        Icons.delete,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                  ],
                  cancelAction: AdaptiveBottomSheetCancelAction(
                    title: const Text('Cancel'),
                  ),
                );
              },
              child: const Text('Bottom Sheet'),
            )),
        const SizedBox(height: 10.0),
        ExampleWidget(
            name: "Adaptive Context Menu",
            child: Row(
              children: [
                AdaptiveContextMenu(
                  actions: [
                    AdaptiveContextMenuItem(
                      text: "Create",
                      onPressed: () => displayDialog(context, "Create"),
                    ),
                    AdaptiveContextMenuItem(
                      text: "Read",
                      onPressed: () => displayDialog(context, "Read"),
                    ),
                    AdaptiveContextMenuItem(
                      text: "Update",
                      onPressed: () => displayDialog(context, "Update"),
                    ),
                    AdaptiveContextMenuItem(
                      text: "Delete",
                      onPressed: () => displayDialog(context, "Delete"),
                    ),
                  ],
                  child: Container(
                    color: Colors.green,
                    child: const FlutterLogo(
                      size: 200.0,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key, required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(children: [
        SizedBox(width: 256.0, child: Text(name)),
        const SizedBox(width: 10.0),
        child,
      ]),
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
  const MasterDetailPage({super.key, this.bottomBar});

  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    const kMasterDetailBreakpoint = 620.0;
    final length = Random().nextInt(8) + 1;
    final controller = AdaptiveMasterDetailPageController(length: length);
    //controller.index = 0;

    return AdaptiveMasterDetail(
      paneLayoutDelegate: const ResizablePaneDelegate(
        initialPaneSize: 280,
        minPageSize: kMasterDetailBreakpoint / 2,
        minPaneSize: 175,
        paneSide: PaneSide.start,
      ),
      controller: controller,
      masterBuilder: (context) {
        return AdaptivePage(
          appBar: AdaptiveAppBar(
            title: AdaptiveText("Master"),
            actions: [
              AdaptiveAppBarAction(
                  onPressed: () {
                    showAdaptiveModalDialog(
                      context: context,
                      title: const Text("Settings"),
                      content: const Text("Application settings"),
                      primaryButton: AdaptiveModalDialogAction(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .maybePop();
                          },
                          child: const AdaptiveText("OK")),
                    );
                  },
                  icon: AdaptiveIcon(AdaptiveIcons.settings)),
            ],
          ),
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
        );
      },
      pageBuilder: (ctx, index) {
        return AdaptivePage(
          appBar: AdaptiveAppBar(
            leading: AdaptiveIconButton(
                onPressed: () {
                  showAdaptiveModalDialog<void>(
                    context: context,
                    title: const Text("Profile"),
                    content: const Text("Information"),
                    primaryButton: AdaptiveModalDialogAction(
                        onPressed: () => Navigator.pop(context),
                        child: const AdaptiveText("OK")),
                  );
                },
                icon: AdaptiveIcon(AdaptiveIcons.account_circle)),
            title: Text("Master $index"),
            actions: [
              AdaptiveAppBarAction(
                  onPressed: () {
                    showAdaptiveModalDialog<void>(
                      context: context,
                      title: const Text("Call"),
                      content: const Text("Call a friend"),
                      primaryButton: AdaptiveModalDialogAction(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .maybePop(),
                          child: const AdaptiveText("OK")),
                    );
                  },
                  icon: AdaptiveIcon(AdaptiveIcons.phone)),
              AdaptiveAppBarAction(
                  onPressed: () {
                    showAdaptiveModalDialog(
                      context: context,
                      title: const Text("VideoCall"),
                      content: const Text("VideoCall a friend"),
                      primaryButton: AdaptiveModalDialogAction(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .maybePop(),
                          child: const AdaptiveText("OK")),
                    );
                  },
                  icon: AdaptiveIcon(AdaptiveIcons.videocam))
            ],
          ),
          bottomBar: bottomBar,
          child: Center(child: Text("Detail $index")),
        );
      },
    );
  }
}
