import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../flutter_adaptive.dart';

class MacosUICheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return MacosCheckbox(value: widget.value, onChanged: widget.onChanged);
  }
}
