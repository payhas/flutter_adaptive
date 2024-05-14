import 'package:flutter/material.dart';

import '../../../base/adaptive_function_builder.dart';
import '../../../common/adaptive_modal_bottom_sheet.dart';

class MaterialModalBottomSheetBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalBottomSheet<T>, T> {
  @override
  Future<T?> build(
      BuildContext context, AdaptiveModalBottomSheet<T> component) {
    final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
      context: context,
      elevation: 0,
      isDismissible: component.isDismissible,
      enableDrag: component.isDismissible,
      isScrollControlled: true,
      backgroundColor: component.bottomSheetColor ??
          sheetTheme.modalBackgroundColor ??
          sheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(component.androidBorderRadius ?? 30),
          topRight: Radius.circular(component.androidBorderRadius ?? 30),
        ),
      ),
      useRootNavigator: component.useRootNavigator ?? false,
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
