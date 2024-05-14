import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruModalBottomSheetBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalBottomSheet>
    implements ShowAdaptiveModalBottomSheet {
  @override
  Widget build(BuildContext context, AdaptiveModalBottomSheet widget) {
    return const SizedBox.shrink();
  }

  @override
  Future<T?> showAdaptiveModalBottomSheet<T>({
    required BuildContext context,
    required List<BottomSheetAction> actions,
    Widget? title,
    CancelAction? cancelAction,
    Color? bottomSheetColor,
    double? androidBorderRadius,
    bool isDismissible = true,
    bool? useRootNavigator,
  }) async {
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
