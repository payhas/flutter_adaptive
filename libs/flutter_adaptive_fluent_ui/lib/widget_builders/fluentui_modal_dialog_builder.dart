import 'dart:ffi';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUIModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return fluentuiDialog(
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

Widget fluentuiDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
  double? width,
  double? height,
}) {
  return ((width != null && width > 0) || (height != null && height > 0))
      ? ContentDialog(
          constraints: BoxConstraints(
            maxWidth: width ?? double.infinity,
            maxHeight: height ?? double.infinity,
          ),
          title: title,
          content: SizedBox(
            width: width,
            height: height,
            child: content,
          ),
          actions: [
            FilledButton(
              onPressed: primaryButton.onPressed,
              child: primaryButton.child,
            ),
            if (secondaryButton != null)
              Button(
                onPressed: secondaryButton.onPressed,
                child: secondaryButton.child,
              ),
          ],
        )
      : ContentDialog(
          title: title,
          content: content,
          actions: [
            FilledButton(
              onPressed: primaryButton.onPressed,
              child: primaryButton.child,
            ),
            if (secondaryButton != null)
              Button(
                onPressed: secondaryButton.onPressed,
                child: secondaryButton.child,
              ),
          ],
        );
}
