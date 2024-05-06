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
              widgetName: "AdaptiveText",
              widget: AdaptiveText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")),
          const SizedBox(height: 10.0),
          ExampleWidget(
              widgetName: "AdaptiveTextInput",
              widget: AdaptiveTextInput(
                placeholder: "Placeholder",
              )),
          const SizedBox(height: 10.0),
          ExampleWidget(
              widgetName: "AdaptiveTextButton",
              widget: AdaptiveTextButton(() {},
                  child: const Text("Adaptive Text Button"))),
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
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget(
      {super.key, required this.widgetName, required this.widget});

  final String widgetName;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widgetName),
      const SizedBox(width: 10.0),
      Expanded(child: widget),
    ]);
  }
}
