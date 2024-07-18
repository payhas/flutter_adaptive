import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentUITextInputBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput component) {
    return TextBox(
      placeholder: component.placeholder,
      controller: component.controller,
      onChanged: component.onChanged,
    );
  }
}
