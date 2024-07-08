import '../../../flutter_adaptive.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentUITextInputBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput widget) {
    return TextBox(
      placeholder: widget.placeholder,
    );
  }
}
