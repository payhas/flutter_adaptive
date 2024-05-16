import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUISliderBuilder extends AdaptiveWidgetBuilder<AdaptiveSlider> {
  @override
  Widget build(BuildContext context, AdaptiveSlider widget) {
    return MacosSlider(
        value: widget.value, onChanged: widget.onChanged ?? (changeValue) {});
  }
}
