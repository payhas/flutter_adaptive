import 'adaptive_widget_builder.dart';
import 'adaptive_widget_builder_selector.dart';
import 'adaptive_appearance_manager.dart';

abstract class AdaptiveBundle {
  AdaptiveBundle({
    this.appearanceManagers,
    this.widgetBuilders,
    this.widgetBuilderSelectors,
    this.bundles,
  });

  final Set<AdaptiveAppearanceManager>? appearanceManagers;

  final Set<AdaptiveWidgetBuilder>? widgetBuilders;
  final Set<AdaptiveWidgetBuilderSelector>? widgetBuilderSelectors;

  final Set<AdaptiveBundle>? bundles;
}
