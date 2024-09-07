import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog<T> component) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return cupertinoDialog(
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

Widget cupertinoDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
}) {
  return CupertinoAlertDialog(
    title: title,
    content: content,
    actions: <CupertinoDialogAction>[
      if (secondaryButton != null)
        CupertinoDialogAction(
          onPressed: secondaryButton.onPressed,
          child: secondaryButton.child,
        ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: primaryButton.onPressed,
        child: primaryButton.child,
      ),
    ],
  );
}
