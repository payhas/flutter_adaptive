import 'package:fluent_ui/fluent_ui.dart';
import '../../../flutter_adaptive.dart';

class FluentUITextButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextButton> {
  @override
  Widget build(BuildContext context, widget) {
    return HyperlinkButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
