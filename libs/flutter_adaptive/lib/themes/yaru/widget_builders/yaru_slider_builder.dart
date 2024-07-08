import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class YaruSliderBuilder extends AdaptiveWidgetBuilder<AdaptiveSlider> {
  @override
  Widget build(BuildContext context, AdaptiveSlider widget) {
    return Slider(value: widget.value, onChanged: widget.onChanged);
  }
}
