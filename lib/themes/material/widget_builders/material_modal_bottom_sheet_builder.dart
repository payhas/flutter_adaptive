import 'package:flutter/material.dart';
import 'package:flutter_adaptive/common/adaptive_modal_bottom_sheet.dart';

class MaterialModalBottomSheetBuilder extends AdaptiveModalBottomSheet {
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
    final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
      context: context,
      elevation: 0,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      backgroundColor: bottomSheetColor ??
          sheetTheme.modalBackgroundColor ??
          sheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(androidBorderRadius ?? 30),
          topRight: Radius.circular(androidBorderRadius ?? 30),
        ),
      ),
      useRootNavigator: useRootNavigator ?? false,
      builder: (BuildContext coxt) {
        final double screenHeight = MediaQuery.of(context).size.height;
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
                      onTap: () => action.onPressed(coxt),
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
                          cancelAction.onPressed!(coxt);
                        } else {
                          Navigator.of(coxt).pop();
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
      },
    );
  }
}
