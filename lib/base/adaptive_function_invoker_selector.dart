import 'package:flutter_adaptive/base/adaptive_function.dart';

import 'adaptive_component_implementation_selector.dart';
import 'adaptive_function_invoker.dart';

abstract class AdaptiveFunctionInvokerSelector
    extends AdaptiveComponentImplementationSelector<AdaptiveFunctionInvoker> {}

class DefaultFunctionInvokerSelector extends AdaptiveFunctionInvokerSelector {
  @override
  AdaptiveFunctionInvoker<AdaptiveFunction, dynamic>? select(
      String componentName,
      Set<AdaptiveFunctionInvoker<AdaptiveFunction, dynamic>>? componentList,
      Map<String, dynamic> appearance) {
    return componentList?.firstOrNull;
  }
}
