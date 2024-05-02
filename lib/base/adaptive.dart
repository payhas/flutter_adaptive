import 'package:flutter/widgets.dart';

import 'adaptive_bundle.dart';
import 'adaptive_widget_builder.dart';
import 'adaptive_widget_builder_selector.dart';
import 'adaptive_appearance_manager.dart';

class Adaptive extends StatefulWidget implements AdaptiveBundle {
  const Adaptive({
    required this.builder,
    super.key,
    this.appearance,
    this.appearanceManagers,
    this.widgetBuilders,
    this.widgetBuilderSelectors,
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

  final Map<String, Set<AdaptiveWidgetBuilder>> widgetBuilders = {};

  final Set<AdaptiveWidgetBuilderSelector> widgetBuilderSelectors = {};

  final Map<String, AdaptiveWidgetBuilder> widgetBuildersActive = {};

  AdaptiveState get state => AdaptiveState._(this);

  @override
  void initState() {
    super.initState();

    _setupAppearance(widget.appearance);

    _setupBundle(widget);
    _setupWidgetBuilderSelectors({
      DefaultWidgetBuilderSelector(),
    });

    _selectWidgetBuilders();
  }

  void _setupBundle(AdaptiveBundle bundle) {
    _setupAppearanceManagers(bundle.appearanceManagers);
    _setupWidgetBuilders(bundle.widgetBuilders);
    _setupWidgetBuilderSelectors(bundle.widgetBuilderSelectors);

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

  _setupWidgetBuilders(Set<AdaptiveWidgetBuilder>? extraWidgetBuilders) {
    extraWidgetBuilders?.forEach((widgetBuilder) {
      if (!widgetBuilders.containsKey(widgetBuilder.widgetName)) {
        widgetBuilders.addAll({widgetBuilder.widgetName: {}});
      }

      if (!widgetBuilders[widgetBuilder.widgetName]!.contains(widgetBuilder)) {
        widgetBuilders[widgetBuilder.widgetName]!.add(widgetBuilder);
      }
    });
  }

  _setupWidgetBuilderSelectors(
      Set<AdaptiveWidgetBuilderSelector>? extraWidgetBuilderSelectors) {
    if (extraWidgetBuilderSelectors != null) {
      widgetBuilderSelectors.addAll(extraWidgetBuilderSelectors);
    }
  }

  _selectWidgetBuilders() {
    widgetBuildersActive.clear();

    for (final widgetName in widgetBuilders.keys) {
      for (var widgetBuilderSelector in widgetBuilderSelectors) {
        var builder = widgetBuilderSelector.select(
            widgetName, widgetBuilders[widgetName], appearance);

        if (builder != null) {
          widgetBuildersActive.addAll({widgetName: builder});
          break;
        }
      }
    }
  }

  void setAppearance(String name, dynamic value) {
    setState(() {
      appearance.addAll({name: value});
      _selectWidgetBuilders();
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
    return _parent.widgetBuildersActive[widgetName];
  }

  AdaptiveAppearanceManager? getAppearanceManager(String name) {
    return _parent.appearanceManagers.where((x) => x.name == name).lastOrNull;
  }

  void setAppearance(String name, dynamic value) {
    _parent.setAppearance(name, value);
  }
}
