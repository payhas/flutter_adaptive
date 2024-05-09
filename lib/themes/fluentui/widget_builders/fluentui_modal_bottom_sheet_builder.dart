import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIModalBottomSheetBuilder extends AdaptiveModalBottomSheet {
  @override
  Future<T?> showModBottomSheet<T>(
      BuildContext context, List<BottomSheetAction> actions,
      {CancelAction? cancelAction,
      Color? bottomSheetColor,
      double? androidBorderRadius,
      Widget? title,
      bool isDismissible = true,
      bool? useRootNavigator}) {
    return MaterialModalBottomSheetBuilder().showModBottomSheet(
        context, actions,
        cancelAction: cancelAction,
        bottomSheetColor: bottomSheetColor,
        androidBorderRadius: androidBorderRadius,
        title: title,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator);
  }
}
