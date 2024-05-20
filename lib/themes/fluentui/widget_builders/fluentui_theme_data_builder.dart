import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIThemeDataBuilder extends AdaptiveThemeDataBuilder {
  @override
  build(BuildContext context, AdaptiveThemeData component) {
    FluentThemeData(
      brightness: component.brightness,
    );
  }
}
