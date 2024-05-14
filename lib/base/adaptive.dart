import 'package:flutter/widgets.dart';

import 'adaptive_bundle.dart';
import 'adaptive_appearance_manager.dart';
import 'adaptive_component.dart';
import 'adaptive_component_builder.dart';
import 'adaptive_component_builder_selector.dart';
import 'adaptive_component_builder_manager.dart';

class Adaptive extends StatefulWidget implements AdaptiveBundle {
  const Adaptive({
    required this.builder,
    super.key,
    this.appearance,
    this.appearanceManagers,
    this.builders,
    this.builderSelectors,
    this.bundles,
  });

  final WidgetBuilder builder;

  final Map<String, dynamic>? appearance;

  @override
  final Set<AdaptiveAppearanceManager>? appearanceManagers;

  @override
  final Set<AdaptiveComponentBuilder>? builders;
  @override
  final Set<AdaptiveComponentBuilderSelector>? builderSelectors;

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

  final AdaptiveComponentBuilderManager componentBuilderManager =
      AdaptiveComponentBuilderManager();

  AdaptiveState get state => AdaptiveState._(this);

  @override
  void initState() {
    super.initState();

    _setupAppearance(widget.appearance);

    _setupBundle(widget);

    componentBuilderManager.setupBuilderSelectors({
      DefaultComponentBuilderSelector(),
    });

    componentBuilderManager.selectBuilder(appearance);
  }

  void _setupBundle(AdaptiveBundle bundle) {
    _setupAppearanceManagers(bundle.appearanceManagers);

    componentBuilderManager.setupBuilders(bundle.builders);
    componentBuilderManager.setupBuilderSelectors(bundle.builderSelectors);

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
      componentBuilderManager.selectBuilder(appearance);
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

  AdaptiveComponentBuilder<T, R>? getBuilder<T extends AdaptiveComponent<R>, R>(
      String componentName) {
    var builder = _parent.componentBuilderManager.buildersActive[componentName];
    if (builder is AdaptiveComponentBuilder<T, R>) {
      return builder;
    }

    return null;
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
