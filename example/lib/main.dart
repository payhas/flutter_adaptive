import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

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
      builder: (context) => AdaptiveApp(
        home: MyHomePage(title: 'Flutter Adaptive'),
        debugShowCheckedModeBanner: false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Material"),
                      onTap: () {
                        _setThemeMaterial();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Cupertino"),
                      onTap: () {
                        _setThemeCupertino();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text("Fluent UI"),
                      onTap: () {
                        _setThemeFluentUI();
                      },
                    ),
                  ])
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
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
                  onPressed: () {}, icon: const Icon(Icons.add_call))),
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
          Row(children: [
            const Text("Adaptive Switch"),
            const SizedBox(width: 10.0),
            AdaptiveSwitch(
              value: isSwitchOn,
              onChanged: (value) {
                setState(() {
                  isSwitchOn = value;
                });
              },
            ),
          ]),
          ExampleWidget(
              name: "Adaptive Circular Progress Indicator",
              child: AdaptiveCircularProgressIndicator(
                value: null,
              )),
          SizedBox(height: 10),
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
                    showDialog<String>(
                        context: context,
                        builder: (context) => AdaptiveModalDialog(
                              title: const Text("Simple Dialog"),
                              content:
                                  const Text("Adaptive Modal Dialog content"),
                              actions: [
                                AdaptiveTextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel')),
                                AdaptiveTextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK')),
                              ],
                            ));
                  },
                  child: const Text("Simple Dialog"))),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "Adaptive Modal Bottom Sheet",
              child: AdaptiveElevatedButton(
                onPressed: () {
                  showAdaptiveModalBottomSheet(
                    context: context,
                    title: const Text('This is the title'),
                    actions: <BottomSheetAction>[
                      BottomSheetAction(
                        title: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: (_) {},
                        leading: const Icon(Icons.add, size: 25),
                      ),
                      BottomSheetAction(
                        title: const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: (_) {},
                        leading: const Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    ],
                    cancelAction: CancelAction(title: const Text('Cancel')),
                  );
                },
                child: const Text('Bottom Sheet'),
              )),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveContextMenu",
              child: Row(
                children: [
                  AdaptiveContextMenu(
                    actions: [
                      AdaptiveContextMenuItem(
                        child: const Text("Create"),
                        onPressed: () => displayDialog(context, "Create"),
                      ),
                      AdaptiveContextMenuItem(
                        child: const Text("Read"),
                        onPressed: () => displayDialog(context, "Read"),
                      ),
                      AdaptiveContextMenuItem(
                        child: const Text("Update"),
                        onPressed: () => displayDialog(context, "Update"),
                      ),
                      AdaptiveContextMenuItem(
                        child: const Text("Delete"),
                        onPressed: () => displayDialog(context, "Delete"),
                      ),
                    ],
                    child: const FlutterLogo(size: 200.0),
                  ),
                  AdaptiveContextMenu(
                    actions: [
                      AdaptiveContextMenuItem(
                        child: const Text("Copy"),
                        onPressed: () => displayDialog(context, "Copy"),
                      ),
                      AdaptiveContextMenuItem(
                        child: const Text("Paste"),
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
      SizedBox(width: 100.0, child: Text(name)),
      const SizedBox(width: 10.0),
      child,
    ]);
  }
}

void displayDialog(BuildContext context, String message) {
  showDialog<String>(
      context: context,
      builder: (context) => AdaptiveModalDialog(
            title: const Text("context menu dialog"),
            content: Text("You clicked context menu item '$message'."),
          ));
}
