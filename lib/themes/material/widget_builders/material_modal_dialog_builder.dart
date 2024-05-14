import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return materialDialog(
          context,
          component.title,
          component.content,
          component.primaryButton,
          component.secondaryButton,
        );
      },
    );
  }
}

Widget materialDialog(
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
