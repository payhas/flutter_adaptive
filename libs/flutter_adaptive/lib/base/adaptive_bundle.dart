import 'adaptive_appearance_manager.dart';

import 'adaptive_component_builder.dart';
import 'adaptive_component_builder_selector.dart';

abstract class AdaptiveBundle {
  AdaptiveBundle({
    this.appearanceManagers,
    this.builders,
    this.builderSelectors,
    this.bundles,
  });

  final Set<AdaptiveAppearanceManager>? appearanceManagers;

  final Set<AdaptiveComponentBuilder>? builders;
  final Set<AdaptiveComponentBuilderSelector>? builderSelectors;

  final Set<AdaptiveBundle>? bundles;
}
