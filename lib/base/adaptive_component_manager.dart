import 'adaptive_component_implementation.dart';
import 'adaptive_component_implementation_selector.dart';

abstract class AdaptiveComponentManager<
    T extends AdaptiveComponentImplementation,
    S extends AdaptiveComponentImplementationSelector<T>> {
  final Set<S> componentImplementationSelectors = {};
  final Map<String, Set<T>> componentImplementations = {};
  final Map<String, T> componentImplementationsActive = {};

  setupComponentImplementations(Set<T>? extraComponentImplementations) {
    extraComponentImplementations?.forEach((componentImplementation) {
      if (!componentImplementations
          .containsKey(componentImplementation.componentName)) {
        componentImplementations
            .addAll({componentImplementation.componentName: {}});
      }

      if (!componentImplementations[componentImplementation.componentName]!
          .contains(componentImplementation)) {
        componentImplementations[componentImplementation.componentName]!
            .add(componentImplementation);
      }
    });
  }

  setupComponentImplementationSelectors(
      Set<S>? extraComponentImplementationSelectors) {
    if (extraComponentImplementationSelectors != null) {
      componentImplementationSelectors
          .addAll(extraComponentImplementationSelectors);
    }
  }

  selectComponentImplementations(Map<String, dynamic> appearance) {
    componentImplementationsActive.clear();

    for (final componentName in componentImplementations.keys) {
      for (var componentImplementationSelector
          in componentImplementationSelectors) {
        var implementation = componentImplementationSelector.select(
            componentName, componentImplementations[componentName], appearance);

        if (implementation != null) {
          componentImplementationsActive
              .addAll({componentName: implementation});
          break;
        }
      }
    }
  }
}
