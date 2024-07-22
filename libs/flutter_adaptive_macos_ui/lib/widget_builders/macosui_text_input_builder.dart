import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUITextInputBuilder extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput component) {
    return MacosTextField(
      placeholder: component.placeholder,
      controller: component.controller,
      onChanged: component.onChanged,
    );
  }
}
