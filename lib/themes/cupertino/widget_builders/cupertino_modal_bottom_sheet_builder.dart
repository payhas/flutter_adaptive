import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoModalBottomSheetBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalBottomSheet>
    implements ShowAdaptiveModalBottomSheet {
  @override
  Widget build(BuildContext context, AdaptiveModalBottomSheet widget) {
    return const SizedBox.shrink();
  }

  Widget actionSheet(BuildContext context, List<BottomSheetAction> actions,
      {CancelAction? cancelAction,
      Color? bottomSheetColor,
      double? androidBorderRadius,
      Widget? title,
      bool isDismissible = true,
      bool? useRootNavigator}) {
    final defaultTextStyle =
        Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20);

    return CupertinoActionSheet(
      title: title,
      actions: actions.map((action) {
        return Material(
          color: Colors.transparent,
          child: CupertinoActionSheetAction(
            onPressed: () => action.onPressed(context),
            child: Row(
              children: [
                if (action.leading != null) ...[
                  action.leading!,
                  const SizedBox(width: 15),
                ],
                Expanded(
                  child: DefaultTextStyle(
                    style: defaultTextStyle,
                    textAlign: action.leading != null
                        ? TextAlign.start
                        : TextAlign.center,
                    child: action.title,
                  ),
                ),
                if (action.trailing != null) ...[
                  const SizedBox(width: 10),
                  action.trailing!,
                ],
              ],
            ),
          ),
        );
      }).toList(),
      cancelButton: cancelAction != null
          ? CupertinoActionSheetAction(
              onPressed: () {
                if (cancelAction.onPressed != null) {
                  cancelAction.onPressed!(context);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: DefaultTextStyle(
                style: defaultTextStyle.copyWith(color: Colors.lightBlue),
                textAlign: TextAlign.center,
                child: cancelAction.title,
              ),
            )
          : null,
    );
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
    return showCupertinoModalPopup(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator ?? true,
      builder: (BuildContext context) {
        return actionSheet(context, actions,
            cancelAction: cancelAction,
            bottomSheetColor: bottomSheetColor,
            androidBorderRadius: androidBorderRadius,
            title: title,
            isDismissible: isDismissible,
            useRootNavigator: useRootNavigator);
      },
    );
  }
}
