import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUISliderBuilder extends AdaptiveWidgetBuilder<AdaptiveSlider> {
  @override
  Widget build(BuildContext context, AdaptiveSlider widget) {
    return Slider(value: widget.value, onChanged: widget.onChanged);
  }
}
