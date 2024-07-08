import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialSwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return Switch(
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}
