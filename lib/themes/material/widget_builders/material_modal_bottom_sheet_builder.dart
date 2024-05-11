import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialModalBottomSheetBuilder
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
