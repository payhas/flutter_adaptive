import 'package:flutter/cupertino.dart';

import '../../../base/adaptive_widget_builder.dart';
import '../../../components/adaptive_switch.dart';

class CupertinoSwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return CupertinoSwitch(
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}
