import 'themed_appearance_manager.dart';
import '../base/adaptive_function_invoker.dart';
import '../base/adaptive_function_invoker_selector.dart';

class ThemedFunctionInvokerSelector extends AdaptiveFunctionInvokerSelector {
  @override
  AdaptiveFunctionInvoker? select(
    String componentName,
    Set<AdaptiveFunctionInvoker>? componentList,
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
