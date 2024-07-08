import 'package:fluent_ui/fluent_ui.dart';
import '../../../flutter_adaptive.dart';

class FluentUISwitchBuilder extends AdaptiveWidgetBuilder<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context, AdaptiveSwitch widget) {
    return ToggleSwitch(
      onChanged: widget.onChanged,
      checked: widget.value,
    );
  }
}
