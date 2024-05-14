import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialAppBuilder(),
            MaterialTextBuilder(),
            MaterialTextInputBuilder(),
            MaterialTextButtonBuilder(),
            MaterialElevatedButtonBuilder(),
            MaterialIconButtonBuilder(),
            MaterialSliderBuilder(),
            MaterialCheckboxBuilder(),
            MaterialSwitchBuilder(),
            MaterialCircularProgressIndicatorBuilder(),
            MaterialLinearProgressIndicatorBuilder(),
            MaterialDatePickerBuilder(),
            MaterialModalDialogBuilder(),
            MaterialModalDialogActionBuilder(),
            // MaterialModalBottomSheetBuilder(),
            // MaterialContextMenuItemBuilder(),
            // MaterialContextMenuBuilder(),
          },
          functionInvokers: {
            MaterialModalBottomSheetInvoker(),
          },
        );
}
