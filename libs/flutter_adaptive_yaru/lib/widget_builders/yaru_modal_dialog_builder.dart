import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class YaruModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog(
      context: context,
      builder: (context) {
        return yaruDialog(
          context: context,
          title: component.title,
          content: component.content,
          primaryButton: component.primaryButton,
          secondaryButton: component.secondaryButton,
          width: component.width,
          height: component.height,
        );
      },
      barrierDismissible: component.barrierDismissible,
      useRootNavigator: component.useRootNavigator,
      routeSettings: component.routeSettings,
      barrierLabel: component.barrierLabel,
    );
  }
}

Widget yaruDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
  double? width,
  double? height,
}) {
  return ((width != null && width > 0) || (height != null && height > 0))
      ? AlertDialog(
          title: title,
          content: SizedBox(
            width: width,
            height: height,
            child: content,
          ),
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
        )
      : AlertDialog(
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
