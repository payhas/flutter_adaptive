import 'adaptive_component.dart';
import 'adaptive_component_builder.dart';

abstract class AdaptiveComponentBuilderSelector<
    T extends AdaptiveComponentBuilder<C, R>,
    C extends AdaptiveComponent<R>,
    R> {
  String get name => runtimeType.toString();

  T? select(
    String componentName,
    Set<T>? componentList,
    Map<String, dynamic> appearance,
  );

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveComponentBuilderSelector) {
      return name == other.name;
    }

    return false;
  }
}

class DefaultComponentBuilderSelector extends AdaptiveComponentBuilderSelector {
  @override
  AdaptiveComponentBuilder<AdaptiveComponent, dynamic>? select(
    String componentName,
    Set<AdaptiveComponentBuilder<AdaptiveComponent, dynamic>>? componentList,
    Map<String, dynamic> appearance,
  ) {
    return componentList?.lastOrNull;
  }
}
