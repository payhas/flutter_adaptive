import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog(
      context: context,
      builder: (context) {
        return yaruDialog(
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

Widget yaruDialog(
  BuildContext context,
  Widget title,
  Widget content,
  AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
) {
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
