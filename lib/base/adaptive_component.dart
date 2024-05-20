import 'package:flutter/widgets.dart';

abstract mixin class AdaptiveComponent<T> {
  String get name => runtimeType.toString();

  const AdaptiveComponent();

  T build(BuildContext context);
}
