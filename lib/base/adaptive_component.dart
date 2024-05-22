import 'package:flutter/widgets.dart';

import 'adaptive.dart';

abstract mixin class AdaptiveComponent<T> {
  String get name => runtimeType.toString();

  const AdaptiveComponent();

  T build(BuildContext context) {
    var builder = Adaptive.of(context)?.getBuilder(this);
    return builder?.build(context, this);
  }
}
