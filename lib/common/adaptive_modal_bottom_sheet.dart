import 'package:flutter/widgets.dart';

import '../base/adaptive_function.dart';

Future<T?> showAdaptiveModalBottomSheet<T>({
  required BuildContext context,
  required Widget title,
  required List<AdaptiveBottomSheetAction> actions,
  AdaptiveBottomSheetCancelAction? cancelAction,
  bool isDismissible = true,
  bool? useRootNavigator,
  Color? bottomSheetColor,
  double? androidBorderRadius,
}) {
  return AdaptiveModalBottomSheetFunction<T>(
    actions: actions,
    title: title,
    cancelAction: cancelAction,
    bottomSheetColor: bottomSheetColor,
    androidBorderRadius: androidBorderRadius,
    isDismissible: isDismissible,
    useRootNavigator: useRootNavigator,
  ).invoke(context);
}

class AdaptiveModalBottomSheetFunction<T> extends AdaptiveFunction<T> {
  final Widget title;
  final List<AdaptiveBottomSheetAction> actions;
  final AdaptiveBottomSheetCancelAction? cancelAction;
  final bool isDismissible;
  final bool? useRootNavigator;
  final Color? bottomSheetColor;
  final double? androidBorderRadius;

  const AdaptiveModalBottomSheetFunction({
    required this.title,
    required this.actions,
    this.cancelAction,
    this.isDismissible = true,
    this.useRootNavigator,
    this.bottomSheetColor,
    this.androidBorderRadius,
  });
}

class AdaptiveBottomSheetAction {
  final Widget title;
  final void Function(BuildContext context) onPressed;
  final Widget? leading;
  final Widget? trailing;

  AdaptiveBottomSheetAction({
    required this.title,
    required this.onPressed,
    this.leading,
    this.trailing,
  });
}

class AdaptiveBottomSheetCancelAction {
  final Widget title;
  final void Function(BuildContext context)? onPressed;
  final TextStyle? textStyle;

  AdaptiveBottomSheetCancelAction({
    required this.title,
    this.onPressed,
    this.textStyle,
  });
}
