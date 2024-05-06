import 'package:flutter/material.dart';

import '../../../base/adaptive_widget_builder.dart';
import '../../../common/adaptive_switch.dart';

class MaterialSwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return Switch(
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}
