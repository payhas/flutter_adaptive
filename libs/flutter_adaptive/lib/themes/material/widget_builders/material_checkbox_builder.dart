import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialCheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return Checkbox(value: widget.value, onChanged: widget.onChanged);
  }
}
