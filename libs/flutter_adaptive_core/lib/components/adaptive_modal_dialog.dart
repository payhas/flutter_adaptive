import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

Future<T?> showAdaptiveModalDialog<T>({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
  bool barrierDismissible = false,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  String? barrierLabel,
}) {
  return AdaptiveModalDialog<T>(
    title: title,
    content: content,
    primaryButton: primaryButton,
    secondaryButton: secondaryButton,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    barrierLabel: barrierLabel,
  ).build(context);
}

class AdaptiveModalDialog<T> extends AdaptiveFunction<T> {
  const AdaptiveModalDialog({
    required this.title,
    required this.content,
    required this.primaryButton,
    this.secondaryButton,
    this.barrierDismissible = false,
    this.useRootNavigator = true,
    this.routeSettings,
    this.barrierLabel,
  });

  final Widget title;
  final Widget content;
  final AdaptiveModalDialogAction primaryButton;
  final AdaptiveModalDialogAction? secondaryButton;
  final bool barrierDismissible;
  final bool useRootNavigator;
  final RouteSettings? routeSettings;
  final String? barrierLabel;
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
