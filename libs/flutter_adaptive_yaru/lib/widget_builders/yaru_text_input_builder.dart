import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class YaruTextInputBuilder extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput component) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: component.placeholder,
      ),
      controller: component.controller,
      onChanged: component.onChanged,
    );
  }
}
