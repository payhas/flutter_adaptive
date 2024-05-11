import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

abstract class ShowAdaptiveModalBottomSheet {
  Future<T?> showAdaptiveModalBottomSheet<T>({
    required BuildContext context,
    required List<BottomSheetAction> actions,
    Widget? title,
    CancelAction? cancelAction,
    Color? bottomSheetColor,
    double? androidBorderRadius,
    bool isDismissible = true,
    bool? useRootNavigator,
  });
}

class AdaptiveModalBottomSheet extends AdaptiveWidget
    implements ShowAdaptiveModalBottomSheet {
  const AdaptiveModalBottomSheet({
    super.key,
  });

  @override
  Future<T?> showAdaptiveModalBottomSheet<T>(
      {required BuildContext context,
      required List<BottomSheetAction> actions,
      Widget? title,
      CancelAction? cancelAction,
      Color? bottomSheetColor,
      double? androidBorderRadius,
      bool isDismissible = true,
      bool? useRootNavigator}) {
    var builder = Adaptive.of(context)?.getBuilder(name);

    if (builder is ShowAdaptiveModalBottomSheet) {
      ShowAdaptiveModalBottomSheet sheet =
          builder as ShowAdaptiveModalBottomSheet;

      return sheet.showAdaptiveModalBottomSheet(
        context: context,
        actions: actions,
        title: title,
        cancelAction: cancelAction,
        bottomSheetColor: bottomSheetColor,
        androidBorderRadius: androidBorderRadius,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
      );
    } else {
      return MaterialModalBottomSheetBuilder().showAdaptiveModalBottomSheet(
        context: context,
        actions: actions,
        title: title,
        cancelAction: cancelAction,
        bottomSheetColor: bottomSheetColor,
        androidBorderRadius: androidBorderRadius,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
      );
    }
  }
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

Future<T?> showAdaptiveModalBottomSheet<T>(
    {required BuildContext context,
    required List<BottomSheetAction> actions,
    Widget? title,
    CancelAction? cancelAction,
    Color? bottomSheetColor,
    double? androidBorderRadius,
    bool isDismissible = true,
    bool? useRootNavigator}) {
  return const AdaptiveModalBottomSheet().showAdaptiveModalBottomSheet(
    context: context,
    actions: actions,
    title: title,
    cancelAction: cancelAction,
    bottomSheetColor: bottomSheetColor,
    androidBorderRadius: androidBorderRadius,
    isDismissible: isDismissible,
    useRootNavigator: useRootNavigator,
  );
}
