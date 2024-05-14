import 'package:flutter/widgets.dart';

import 'adaptive_component_implementation.dart';
import 'adaptive_widget.dart';

abstract class AdaptiveWidgetBuilder<T extends AdaptiveWidget>
    extends AdaptiveComponentImplementation<T> {
  Widget build(BuildContext context, T widget);
}
