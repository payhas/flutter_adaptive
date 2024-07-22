import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoTextInputBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput component) {
    return CupertinoTextField(
      placeholder: component.placeholder,
      controller: component.controller,
      onChanged: component.onChanged,
    );
  }
}
