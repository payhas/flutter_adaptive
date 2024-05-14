import 'package:flutter/widgets.dart';

import 'adaptive_component_implementation.dart';
import 'adaptive_function.dart';

abstract class AdaptiveFunctionInvoker<T extends AdaptiveFunction<R>, R>
    extends AdaptiveComponentImplementation<T> {
  Future<R?> invoke(BuildContext context, T function);
}
