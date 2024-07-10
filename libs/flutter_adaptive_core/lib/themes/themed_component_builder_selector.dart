import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class ThemedWidgetBuilderSelector extends AdaptiveComponentBuilderSelector {
  @override
  AdaptiveComponentBuilder<AdaptiveComponent, dynamic>? select(
    String componentName,
    Set<AdaptiveComponentBuilder<AdaptiveComponent, dynamic>>? componentList,
    Map<String, dynamic> appearance,
  ) {
    String? theme = appearance[ThemedAppearanceManager.themeAppearanceName];
    if (theme?.isEmpty ?? true) {
      return null;
    }

    return componentList
        ?.where((builder) => builder.name.startsWith(theme!))
        .lastOrNull;
  }
}
