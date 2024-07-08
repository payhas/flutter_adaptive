import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoSwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return CupertinoSwitch(
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}
