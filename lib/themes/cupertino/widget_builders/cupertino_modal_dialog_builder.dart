import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog<T> component) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return cupertinoDialog(
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

Widget cupertinoDialog(
  BuildContext context,
  Widget title,
  Widget content,
  AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
) {
  return CupertinoAlertDialog(
    title: title,
    content: content,
    actions: <CupertinoDialogAction>[
      if (secondaryButton != null)
        CupertinoDialogAction(
          onPressed: secondaryButton!.onPressed,
          child: secondaryButton!.child,
        ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: primaryButton.onPressed,
        child: primaryButton.child,
      ),
    ],
  );
}
