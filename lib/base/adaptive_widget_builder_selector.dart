import 'adaptive_component_implementation_selector.dart';
import 'adaptive_widget_builder.dart';
import 'adaptive_widget.dart';

abstract class AdaptiveWidgetBuilderSelector
    extends AdaptiveComponentImplementationSelector<AdaptiveWidgetBuilder> {}

class DefaultWidgetBuilderSelector extends AdaptiveWidgetBuilderSelector {
  @override
  AdaptiveWidgetBuilder<AdaptiveWidget>? select(
      String componentName,
      Set<AdaptiveWidgetBuilder<AdaptiveWidget>>? componentList,
      Map<String, dynamic> appearance) {
    return componentList?.lastOrNull;
  }
}
