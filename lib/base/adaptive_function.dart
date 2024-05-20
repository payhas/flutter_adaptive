import 'package:flutter/widgets.dart';

import 'adaptive.dart';
import 'adaptive_component.dart';

abstract class AdaptiveFunction<T> with AdaptiveComponent<Future<T?>> {
  const AdaptiveFunction();

  @override
  Future<T?> build(BuildContext context) {
    var builder =
        Adaptive.of(context)?.getBuilder<AdaptiveFunction<T>, Future<T?>>(name);
    if (builder != null) {
      return builder.build(context, this);
    }

    if ((T).toString() != (dynamic).toString()) {
      var dynamicBuilder = Adaptive.of(context)
          ?.getBuilder<AdaptiveFunction, Future<dynamic>>(getDynamicName(name));
      if (dynamicBuilder != null) {
        return dynamicBuilder.build(context, this).then((x) => x as T?);
      }
    }

    return Future.value(null);
  }

  static String getDynamicName(String name) {
    return '${name.substring(0, name.lastIndexOf('<'))}<dynamic>';
  }
}
