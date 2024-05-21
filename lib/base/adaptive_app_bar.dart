import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'adaptive_component.dart';

class AdaptiveAppBar with AdaptiveComponent {
  const AdaptiveAppBar({this.title});

  final Widget? title;

  @override
  dynamic build(BuildContext context) {
    var builder =
        Adaptive.of(context)?.getBuilder<AdaptiveAppBar, dynamic>(name);
    return builder?.build(context, this);
  }
}
