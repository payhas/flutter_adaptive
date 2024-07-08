import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialTextInputBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput widget) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.placeholder,
      ),
    );
  }
}
