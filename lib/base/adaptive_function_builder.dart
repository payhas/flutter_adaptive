import 'adaptive_component_builder.dart';
import 'adaptive_function.dart';

abstract class AdaptiveFunctionBuilder<T extends AdaptiveFunction<R>, R>
    extends AdaptiveComponentBuilder<T, Future<R?>> {}
