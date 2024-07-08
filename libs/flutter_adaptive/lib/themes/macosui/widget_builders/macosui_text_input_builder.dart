import 'package:flutter/widgets.dart';
import '../../../flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUITextInputBuilder extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput widget) {
    return MacosTextField(
      placeholder: widget.placeholder,
    );
  }
}
