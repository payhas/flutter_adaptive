import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive/common/adaptive_modal_bottom_sheet.dart';

class CupertinoModalBottomSheetBuilder extends AdaptiveModalBottomSheet {
  @override
  Future<T?> showModBottomSheet<T>(
      BuildContext context, List<BottomSheetAction> actions,
      {CancelAction? cancelAction,
      Color? bottomSheetColor,
      double? androidBorderRadius,
      Widget? title,
      bool isDismissible = true,
      bool? useRootNavigator}) {
    final defaultTextStyle =
        Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20);
    return showCupertinoModalPopup(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator ?? true,
      builder: (BuildContext coxt) {
        return CupertinoActionSheet(
          title: title,
          actions: actions.map((action) {
            return Material(
              color: Colors.transparent,
              child: CupertinoActionSheetAction(
                onPressed: () => action.onPressed(coxt),
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
                      cancelAction.onPressed!(coxt);
                    } else {
                      Navigator.of(coxt).pop();
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
      },
    );
  }
}
