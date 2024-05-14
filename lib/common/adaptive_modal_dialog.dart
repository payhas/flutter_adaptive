import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

Future<T?> showAdaptiveModalDialog<T>({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
}) {
  return AdaptiveModalDialog<T>(
    title: title,
    content: content,
    primaryButton: primaryButton,
    secondaryButton: secondaryButton,
  ).build(context);
}

class AdaptiveModalDialog<T> extends AdaptiveFunction<T> {
  const AdaptiveModalDialog({
    required this.title,
    required this.content,
    required this.primaryButton,
    this.secondaryButton,
  });

  final Widget title;
  final Widget content;
  final AdaptiveModalDialogAction primaryButton;
  final AdaptiveModalDialogAction? secondaryButton;
}

class AdaptiveModalDialogAction extends AdaptiveWidget {
  const AdaptiveModalDialogAction({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
}
