import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIModalDialogActionBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialogAction> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialogAction widget) {
    return Button(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
