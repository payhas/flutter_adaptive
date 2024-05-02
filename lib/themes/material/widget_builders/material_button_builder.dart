import 'package:flutter/material.dart';

import '../../../base/adaptive_widget_builder.dart';
import '../../../common/adaptive_button.dart';

class MaterialButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveButton> {
  @override
  Widget build(BuildContext context, AdaptiveButton widget) {
    return MaterialButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
