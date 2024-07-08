import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';
import 'package:yaru/widgets.dart';

class YaruCheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return YaruCheckbox(value: widget.value, onChanged: widget.onChanged);
  }
}
