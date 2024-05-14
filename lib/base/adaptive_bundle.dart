import 'adaptive_appearance_manager.dart';

import 'adaptive_widget_builder.dart';
import 'adaptive_widget_builder_selector.dart';

import 'adaptive_function_invoker.dart';
import 'adaptive_function_invoker_selector.dart';

abstract class AdaptiveBundle {
  AdaptiveBundle({
    this.appearanceManagers,
    this.widgetBuilders,
    this.widgetBuilderSelectors,
    this.functionInvokers,
    this.functionInvokerSelectors,
    this.bundles,
  });

  final Set<AdaptiveAppearanceManager>? appearanceManagers;

  final Set<AdaptiveWidgetBuilder>? widgetBuilders;
  final Set<AdaptiveWidgetBuilderSelector>? widgetBuilderSelectors;

  final Set<AdaptiveFunctionInvoker>? functionInvokers;
  final Set<AdaptiveFunctionInvokerSelector>? functionInvokerSelectors;

  final Set<AdaptiveBundle>? bundles;
}
