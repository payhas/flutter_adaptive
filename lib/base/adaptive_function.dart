import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/base/adaptive_function_invoker.dart';

import 'adaptive.dart';

abstract class AdaptiveFunction<T> {
  String get name => runtimeType.toString();

  const AdaptiveFunction();

  Future<T?> invoke(BuildContext context) {
    var invoker = Adaptive.of(context)?.getInvoker(name);
    if (invoker != null &&
        invoker is AdaptiveFunctionInvoker<AdaptiveFunction<T>, T>) {
      return invoker.invoke(context, this);
    }

    if ((T).toString() != (dynamic).toString()) {
      invoker = Adaptive.of(context)?.getInvoker(getDynamicName(name));
      if (invoker != null) {
        return invoker.invoke(context, this).then((x) => x as T?);
      }
    }

    return Future.value(null);
  }

  static String getDynamicName(String name) {
    return '${name.substring(0, name.lastIndexOf('<'))}<dynamic>';
  }
}
