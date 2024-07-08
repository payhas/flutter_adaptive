import 'adaptive_component_builder.dart';
import 'adaptive_component_builder_selector.dart';

class AdaptiveComponentBuilderManager {
  final Set<AdaptiveComponentBuilderSelector> selectors = {};
  final Map<String, Set<AdaptiveComponentBuilder>> builders = {};
  final Map<String, AdaptiveComponentBuilder> buildersActive = {};

  setupBuilders(Set<AdaptiveComponentBuilder>? extraBuilders) {
    extraBuilders?.forEach((builder) {
      if (!builders.containsKey(builder.componentName)) {
        builders.addAll({builder.componentName: {}});
      }

      if (!builders[builder.componentName]!.contains(builder)) {
        builders[builder.componentName]!.add(builder);
      }
    });
  }

  setupBuilderSelectors(
      Set<AdaptiveComponentBuilderSelector>? extraBuilderSelectors) {
    if (extraBuilderSelectors != null) {
      selectors.addAll(extraBuilderSelectors);
    }
  }

  selectBuilder(Map<String, dynamic> appearance) {
    buildersActive.clear();

    for (final componentName in builders.keys) {
      for (var builderSelector in selectors) {
        var builder = builderSelector.select(
            componentName, builders[componentName], appearance);

        if (builder != null) {
          buildersActive.addAll({componentName: builder});
          break;
        }
      }
    }
  }
}
