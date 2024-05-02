import 'adaptive_widget_builder.dart';

abstract class AdaptiveWidgetBuilderSelector {
  String get name => runtimeType.toString();

  AdaptiveWidgetBuilder? select(
    String widgetName,
    Set<AdaptiveWidgetBuilder>? widgetBuilders,
    Map<String, dynamic> appearance,
  );

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveWidgetBuilderSelector) {
      return name == other.name;
    }

    return false;
  }
}

class DefaultWidgetBuilderSelector extends AdaptiveWidgetBuilderSelector {
  @override
  AdaptiveWidgetBuilder? select(
    String widgetName,
    Set<AdaptiveWidgetBuilder>? widgetBuilders,
    Map<String, dynamic> appearance,
  ) {
    return widgetBuilders?.lastOrNull;
  }
}
