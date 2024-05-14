import 'package:flutter/material.dart';

import '../../../base/adaptive_function_invoker.dart';
import '../../../common/adaptive_modal_bottom_sheet.dart';

class MaterialModalBottomSheetInvoker<T>
    extends AdaptiveFunctionInvoker<AdaptiveModalBottomSheetFunction<T>, T> {
  @override
  Future<T?> invoke(
      BuildContext context, AdaptiveModalBottomSheetFunction<T> function) {
    final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
      context: context,
      elevation: 0,
      isDismissible: function.isDismissible,
      enableDrag: function.isDismissible,
      isScrollControlled: true,
      backgroundColor: function.bottomSheetColor ??
          sheetTheme.modalBackgroundColor ??
          sheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(function.androidBorderRadius ?? 30),
          topRight: Radius.circular(function.androidBorderRadius ?? 30),
        ),
      ),
      useRootNavigator: function.useRootNavigator ?? false,
      builder: (BuildContext context) {
        return actionSheet(
          context,
          function.actions,
          cancelAction: function.cancelAction,
          title: function.title,
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final defaultTextStyle =
        Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight - (screenHeight / 10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: title),
                ),
              ],
              ...actions.map<Widget>((action) {
                return InkWell(
                  onTap: () => action.onPressed(context),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
              }),
              if (cancelAction != null)
                InkWell(
                  onTap: () {
                    if (cancelAction.onPressed != null) {
                      cancelAction.onPressed!(context);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultTextStyle(
                        style: defaultTextStyle.copyWith(
                          color: Colors.lightBlue,
                        ),
                        textAlign: TextAlign.center,
                        child: cancelAction.title,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
