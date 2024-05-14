import 'package:flutter/widgets.dart';

import 'adaptive_bundle.dart';
import 'adaptive_appearance_manager.dart';

import 'adaptive_widget_manager.dart';
import 'adaptive_widget_builder.dart';
import 'adaptive_widget_builder_selector.dart';

import 'adaptive_function_manager.dart';
import 'adaptive_function_invoker.dart';
import 'adaptive_function_invoker_selector.dart';

class Adaptive extends StatefulWidget implements AdaptiveBundle {
  const Adaptive({
    required this.builder,
    super.key,
    this.appearance,
    this.appearanceManagers,
    this.widgetBuilders,
    this.widgetBuilderSelectors,
    this.functionInvokers,
    this.functionInvokerSelectors,
    this.bundles,
  });

  final WidgetBuilder builder;

  final Map<String, dynamic>? appearance;

  @override
  final Set<AdaptiveAppearanceManager>? appearanceManagers;

  @override
  final Set<AdaptiveWidgetBuilder>? widgetBuilders;
  @override
  final Set<AdaptiveWidgetBuilderSelector>? widgetBuilderSelectors;

  @override
  final Set<AdaptiveFunctionInvoker>? functionInvokers;
  @override
  final Set<AdaptiveFunctionInvokerSelector>? functionInvokerSelectors;

  @override
  final Set<AdaptiveBundle>? bundles;

  static AdaptiveState? of(BuildContext context) {
    _AdaptiveState? state = context.findAncestorStateOfType<_AdaptiveState>();

    return state?.state;
  }

  @override
  State<Adaptive> createState() => _AdaptiveState();
}

class _AdaptiveState extends State<Adaptive> {
  final Map<String, dynamic> appearance = {};

  final Set<AdaptiveAppearanceManager> appearanceManagers = {};

  final AdaptiveWidgetManager widgetManager = AdaptiveWidgetManager();
  final AdaptiveFunctionManager functionManager = AdaptiveFunctionManager();

  AdaptiveState get state => AdaptiveState._(this);

  @override
  void initState() {
    super.initState();

    _setupAppearance(widget.appearance);

    _setupBundle(widget);

    widgetManager.setupComponentImplementationSelectors({
      DefaultWidgetBuilderSelector(),
    });
    functionManager.setupComponentImplementationSelectors({
      DefaultFunctionInvokerSelector(),
    });

    widgetManager.selectComponentImplementations(appearance);
    functionManager.selectComponentImplementations(appearance);
  }

  void _setupBundle(AdaptiveBundle bundle) {
    _setupAppearanceManagers(bundle.appearanceManagers);
    
    widgetManager.setupComponentImplementations(bundle.widgetBuilders);
    widgetManager
        .setupComponentImplementationSelectors(bundle.widgetBuilderSelectors);

    functionManager.setupComponentImplementations(bundle.functionInvokers);
    functionManager
        .setupComponentImplementationSelectors(bundle.functionInvokerSelectors);

    bundle.bundles?.forEach(_setupBundle);
  }

  _setupAppearance(Map<String, dynamic>? extraAppearance) {
    if (extraAppearance != null) {
      appearance.addAll(extraAppearance);
    }
  }

  _setupAppearanceManagers(
      Set<AdaptiveAppearanceManager>? extraAppearanceManagers) {
    extraAppearanceManagers?.forEach((manager) {
      var existing = appearanceManagers.lookup(manager);
      if (existing != null) {
        return;
      }

      appearanceManagers.add(manager);
      appearance.addAll({manager.appearanceName: manager.initialValue});
    });
  }

  void setAppearance(String name, dynamic value) {
    setState(() {
      appearance.addAll({name: value});
      widgetManager.selectComponentImplementations(appearance);
      functionManager.selectComponentImplementations(appearance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

class AdaptiveState {
  AdaptiveState._(this._parent);

  final _AdaptiveState _parent;

  AdaptiveWidgetBuilder? getBuilder(String widgetName) {
    return _parent.widgetManager.componentImplementationsActive[widgetName];
  }

  AdaptiveFunctionInvoker? getInvoker(String functionName) {
    return _parent.functionManager.componentImplementationsActive[functionName];
  }

  AdaptiveAppearanceManager? getAppearanceManager(String name) {
    return _parent.appearanceManagers.where((x) => x.name == name).lastOrNull;
  }

  void setAppearance(String name, dynamic value) {
    _parent.setAppearance(name, value);
  }

  dynamic getAppearance(String name) {
    return _parent.appearance[name];
  }
}
