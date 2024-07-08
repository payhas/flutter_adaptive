import 'package:flutter/widgets.dart';
import '../../../flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  MacosThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return MacosThemeData(
      brightness: component.brightness,
    );
  }
}
