import 'package:flutter/widgets.dart';

import 'adaptive_component.dart';

abstract class AdaptiveComponentBuilder<T extends AdaptiveComponent<R>, R> {
  String get name => runtimeType.toString();
  String get componentName => (T).toString();

  R build(BuildContext context, T component);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveComponentBuilder<T, R>) {
      return name == other.name;
    }

    return false;
  }
}
