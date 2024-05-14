import 'themed_appearance_manager.dart';
import '../base/adaptive_widget_builder.dart';
import '../base/adaptive_widget_builder_selector.dart';

class ThemedWidgetBuilderSelector extends AdaptiveWidgetBuilderSelector {
  @override
  AdaptiveWidgetBuilder? select(
    String componentName,
    Set<AdaptiveWidgetBuilder>? componentList,
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
