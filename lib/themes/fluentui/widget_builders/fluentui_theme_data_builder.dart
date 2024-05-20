import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIThemeDataBuilder extends AdaptiveThemeDataBuilder {
  @override
  FluentThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return FluentThemeData(
      brightness: component.brightness,
    );
  }
}
