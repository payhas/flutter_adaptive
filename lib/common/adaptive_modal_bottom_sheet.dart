import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

abstract class AdaptiveModalBottomSheet {
  Future<T?> showModBottomSheet<T>(
    BuildContext context,
    List<BottomSheetAction> actions, {
    CancelAction? cancelAction,
    Color? bottomSheetColor,
    double? androidBorderRadius,
    Widget? title,
    bool isDismissible = true,
    bool? useRootNavigator,
  });
}

class BottomSheetAction {
  final Widget title;
  final void Function(BuildContext context) onPressed;
  final Widget? trailing;
  final Widget? leading;

  BottomSheetAction({
    required this.title,
    required this.onPressed,
    this.trailing,
    this.leading,
  });
}

class CancelAction {
  final Widget title;
  final void Function(BuildContext context)? onPressed;
  final TextStyle? textStyle;

  CancelAction({
    required this.title,
    this.onPressed,
    this.textStyle,
  });
}

Map<String, AdaptiveModalBottomSheet> modalBottomSheetBuilders = {
  "Cupertino": CupertinoModalBottomSheetBuilder(),
  "Material": MaterialModalBottomSheetBuilder(),
  "FluentUI": FluentUIModalBottomSheetBuilder(),
};

Future<T?> showAdaptiveModalBottomSheet<T>({
  required BuildContext context,
  Widget? title,
  required List<BottomSheetAction> actions,
  CancelAction? cancelAction,
  Color? bottomSheetColor,
  double? androidBorderRadius,
  bool isDismissible = true,
  bool? useRootNavigator,
}) async {
  String currentTheme = Adaptive.of(context)?.getAppearance()["Theme"];

  return modalBottomSheetBuilders[currentTheme]?.showModBottomSheet(
        context,
        actions,
        title: title,
        cancelAction: cancelAction,
        bottomSheetColor: bottomSheetColor,
        androidBorderRadius: androidBorderRadius,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
      ) ??
      MaterialModalBottomSheetBuilder().showModBottomSheet(context, actions);
}
