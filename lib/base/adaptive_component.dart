import 'package:flutter/widgets.dart';

abstract interface class AdaptiveComponent<T> {
  String get name => runtimeType.toString();
  T build(BuildContext context);
}
