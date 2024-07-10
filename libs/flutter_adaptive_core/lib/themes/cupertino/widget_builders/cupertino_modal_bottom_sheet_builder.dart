import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoModalBottomSheetBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalBottomSheet<T>, T> {
  @override
  Future<T?> build(
      BuildContext context, AdaptiveModalBottomSheet<T> component) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: component.isDismissible,
      useRootNavigator: component.useRootNavigator ?? true,
      builder: (BuildContext context) {
        return actionSheet(
          context,
          component.actions,
          cancelAction: component.cancelAction,
          title: component.title,
        );
      },
    );
  }

  Widget actionSheet(
    BuildContext context,
    List<AdaptiveBottomSheetAction> actions, {
    AdaptiveBottomSheetCancelAction? cancelAction,
    Widget? title,
  }) {
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
}
