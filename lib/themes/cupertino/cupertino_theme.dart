import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoTheme extends AdaptiveBundle {
  CupertinoTheme()
      : super(
          widgetBuilders: {
            CupertinoAppBuilder(),
            CupertinoTextBuilder(),
            CupertinoTextInputBuilder(),
            CupertinoTextButtonBuilder(),
            CupertinoElevatedButtonBuilder(),
            CupertinoIconButtonBuilder(),
            CupertinoSliderBuilder(),
            CupertinoCheckboxBuilder(),
            CupertinoSwitchBuilder(),
            CupertinoCircularProgressIndicatorBuilder(),
            CupertinoLinearProgressIndicatorBuilder(),
            CupertinoDatePickerBuilder(),
            CupertinoModalDialogBuilder(),
            CupertinoModalDialogActionBuilder(),
            // CupertinoModalBottomSheetBuilder(),
            // CupertinoContextMenuItemBuilder(),
            // CupertinoContextMenuBuilder(),
          },
          functionInvokers: {
            CupertinoModalBottomSheetInvoker(),
          },
        );
}
