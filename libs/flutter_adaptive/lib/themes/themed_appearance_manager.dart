import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class ThemedAppearanceManager extends AdaptiveAppearanceManager<String> {
  static const themeAppearanceName = 'Theme';

  ThemedAppearanceManager({
    this.defaultTheme,
  });

  final String? defaultTheme;

  @override
  String get appearanceName => themeAppearanceName;

  @override
  String? get initialValue => defaultTheme;

  static setThemeOf(BuildContext context, String theme) {
    Adaptive.of(context)?.setAppearance(themeAppearanceName, theme);
  }
}
