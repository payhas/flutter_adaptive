import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUIModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showMacosAlertDialog<T>(
      context: context,
      builder: (context) {
        return macosuiDialog(
          context,
          component.title,
          component.content,
          component.primaryButton,
          component.secondaryButton,
        );
      },
      barrierDismissible: component.barrierDismissible,
      useRootNavigator: component.useRootNavigator,
      routeSettings: component.routeSettings,
      barrierLabel: component.barrierLabel,
    );
  }
}

Widget macosuiDialog(
  BuildContext context,
  Widget title,
  Widget content,
  AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
) {
  return (secondaryButton != null)
      ? MacosAlertDialog(
          appIcon: const FlutterLogo(),
          title: title,
          message: content,
          primaryButton: PushButton(
            controlSize: ControlSize.large,
            onPressed: primaryButton.onPressed,
            child: primaryButton.child,
          ),
          secondaryButton: PushButton(
            controlSize: ControlSize.large,
            secondary: true,
            onPressed: secondaryButton.onPressed,
            child: secondaryButton.child,
          ),
        )
      : MacosAlertDialog(
          appIcon: const FlutterLogo(),
          title: title,
          message: content,
          primaryButton: PushButton(
            controlSize: ControlSize.large,
            onPressed: primaryButton.onPressed,
            child: primaryButton.child,
          ),
        );
}
