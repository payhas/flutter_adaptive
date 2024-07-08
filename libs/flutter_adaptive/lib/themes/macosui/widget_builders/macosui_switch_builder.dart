import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../flutter_adaptive.dart';

class MacosUISwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return MacosSwitch(
      onChanged: widget.onChanged,
      value: widget.value,
    );
  }
}
