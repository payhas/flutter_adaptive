import 'package:flutter/widgets.dart';

abstract class AdaptiveWidgetBuilder<T> {
  String get name => runtimeType.toString();
  String get widgetName => (T).toString();

  Widget build(BuildContext context, T widget);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveWidgetBuilder) {
      return name == other.name;
    }

    return false;
  }
}
