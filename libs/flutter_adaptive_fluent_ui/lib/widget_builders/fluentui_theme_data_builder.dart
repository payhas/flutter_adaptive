import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUIThemeDataBuilder
    extends AdaptiveComponentBuilder<AdaptiveThemeData, dynamic> {
  @override
  FluentThemeData? build(BuildContext context, AdaptiveThemeData component) {
    return FluentThemeData(
      brightness: component.brightness,
    );
  }
}
