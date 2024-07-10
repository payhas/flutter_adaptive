import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUIElevatedButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveElevatedButton> {
  @override
  Widget build(BuildContext context, widget) {
    return PushButton(
      controlSize: ControlSize.large,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
