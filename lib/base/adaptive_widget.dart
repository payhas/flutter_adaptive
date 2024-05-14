import 'package:flutter/widgets.dart';

import 'adaptive.dart';
import 'adaptive_component.dart';

abstract class AdaptiveWidget extends StatelessWidget
    implements AdaptiveComponent<Widget> {
  @override
  String get name => runtimeType.toString();

  const AdaptiveWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var builder =
        Adaptive.of(context)?.getBuilder<AdaptiveWidget, Widget>(name);
    return builder?.build(context, this) ?? const SizedBox.shrink();
  }
}
