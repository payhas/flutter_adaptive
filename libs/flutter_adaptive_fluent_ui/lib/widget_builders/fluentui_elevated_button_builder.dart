import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIElevatedButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveElevatedButton> {
  @override
  Widget build(BuildContext context, widget) {
    return Button(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
