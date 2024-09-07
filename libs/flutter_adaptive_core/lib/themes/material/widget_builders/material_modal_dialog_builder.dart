import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return materialDialog(
          context: context,
          title: component.title,
          content: component.content,
          primaryButton: component.primaryButton,
          secondaryButton: component.secondaryButton,
        );
      },
      barrierDismissible: component.barrierDismissible,
      useRootNavigator: component.useRootNavigator,
      routeSettings: component.routeSettings,
      barrierLabel: component.barrierLabel,
    );
  }
}

Widget materialDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
}) {
  return AlertDialog(
    title: title,
    content: content,
    actions: <Widget>[
      if (secondaryButton != null)
        TextButton(
          onPressed: secondaryButton.onPressed,
          child: secondaryButton.child,
        ),
      TextButton(
        onPressed: primaryButton.onPressed,
        child: primaryButton.child,
      ),
    ],
  );
}
