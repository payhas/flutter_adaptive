import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIThemeDataBuilder extends AdaptiveThemeDataBuilder {
  @override
  MacosThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return MacosThemeData(
      brightness: component.brightness,
    );
  }
}
