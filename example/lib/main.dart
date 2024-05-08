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
              name: "AdaptiveText",
              child: Expanded(
                child: AdaptiveText(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
              )),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveTextInput",
              child: Expanded(
                child: AdaptiveTextInput(
                  placeholder: "Placeholder",
                ),
              )),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveTextButton",
              child: AdaptiveTextButton(() {},
                  child: const Text("Adaptive Text Button"))),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveElevatedButton",
              child: AdaptiveElevatedButton(
                () {},
                child: const Text("Adaptive Elevated Button"),
              )),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveIconButton",
              child:
                  AdaptiveIconButton(() {}, icon: const Icon(Icons.add_call))),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveSlider",
              child: AdaptiveSlider(
                  value: _currentSliderValue,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  })),
          const SizedBox(height: 10.0),
          ExampleWidget(
              name: "AdaptiveCheckBox",
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
            const Text("AdaptiveSwitch"),
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
          Row(children: [
            Text("AdaptiveCircularProgressIndicator"),
            SizedBox(width: 10.0),
            AdaptiveCircularProgressIndicator(
              value: null,
            ),
          ]),
          SizedBox(height: 10),
          Row(children: [
            Text("AdaptiveLinearProgressIndicator"),
            SizedBox(width: 10.0),
            SizedBox(
              height: 10,
              width: 200,
              child: AdaptiveLinearProgressIndicator(
                value: 56,
              ),
            ),
          ]),
          const SizedBox(height: 10.0),
          ExampleWidget(
            name: "AdaptiveDatePicker",
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
          SizedBox(height: 10),
          Row(children: [
            Text("AdaptiveModalDialog"),
            SizedBox(width: 10.0),
            AdaptiveElevatedButton(() {
              showDialog<String>(
                  context: context,
                  builder: (context) => AdaptiveModalDialog(
                        title: const Text("Simple Dialog"),
                        content: const Text("Adaptive Modal Dialog content"),
                        actions: [
                          AdaptiveTextButton(
                              () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel')),
                          AdaptiveTextButton(() => Navigator.pop(context, 'OK'),
                              child: const Text('OK')),
                        ],
                      ));
            }, child: const Text("Simple Dialog")),
          ]),
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
      Text(name),
      const SizedBox(width: 10.0),
      child,
    ]);
  }
}
