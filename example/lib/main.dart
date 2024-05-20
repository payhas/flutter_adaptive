import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:provider/provider.dart';

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
            home: MyHomePage(title: 'Flutter Adaptive'),
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

  void _setThemeFluentUI() {
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
    return AdaptiveScaffold(
      body: ListView(
        padding: const EdgeInsets.all(10.0),
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
                  placeholder: "Placeholder",
                ),
              )),
          const SizedBox(height: 10.0),
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
                  onPressed: () {},
                  icon: const AdaptiveIcon(AdaptiveIcons.add))),
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
                    child: const FlutterLogo(size: 200.0),
                  ),
                  AdaptiveContextMenu(
                    actions: [
                      AdaptiveContextMenuItem(
                        text: "Copy",
                        onPressed: () => displayDialog(context, "Copy"),
                      ),
                      AdaptiveContextMenuItem(
                        text: "Paste",
                        onPressed: () => displayDialog(context, "Paste"),
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
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key, required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 256.0, child: Text(name)),
      const SizedBox(width: 10.0),
      child,
    ]);
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
