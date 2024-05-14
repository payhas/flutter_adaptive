import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUIModalDialogActionBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialogAction> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialogAction widget) {
    return PushButton(
      controlSize: ControlSize.large,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
