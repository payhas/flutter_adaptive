import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

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
