import 'package:flutter/widgets.dart';

import 'adaptive_component_builder.dart';
import 'adaptive_widget.dart';

abstract class AdaptiveWidgetBuilder<T extends AdaptiveWidget>
    extends AdaptiveComponentBuilder<T, Widget> {
  const AdaptiveWidgetBuilder();
}
