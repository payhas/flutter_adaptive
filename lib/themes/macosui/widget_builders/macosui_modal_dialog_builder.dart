import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUIModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return (widget.secondaryButton != null)
        ? MacosAlertDialog(
            appIcon: const FlutterLogo(),
            title: widget.title ?? const Text(""),
            message: widget.content ?? const Text(""),
            primaryButton: PushButton(
              controlSize: ControlSize.large,
              onPressed: widget.primaryButton.onPressed,
              child: widget.primaryButton.child,
            ),
            secondaryButton: PushButton(
              controlSize: ControlSize.large,
              secondary: true,
              onPressed: widget.secondaryButton!.onPressed,
              child: widget.secondaryButton!.child,
            ),
          )
        : MacosAlertDialog(
            appIcon: const FlutterLogo(),
            title: widget.title ?? const Text(""),
            message: widget.content ?? const Text(""),
            primaryButton: PushButton(
              controlSize: ControlSize.large,
              onPressed: widget.primaryButton.onPressed,
              child: widget.primaryButton.child,
            ),
          );
  }
}
