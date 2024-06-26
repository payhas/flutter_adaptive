import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          builders: {
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
            MaterialModalBottomSheetBuilder(),
            MaterialContextMenuItemBuilder(),
            MaterialContextMenuBuilder(),
            MaterialPageBuilder(),
            MaterialThemeDataBuilder(),
            MaterialAppBarBuilder(),
            MaterialNavigationBuilder(),
            MaterialMasterDetailBuilder(),
            MaterialDetailPageBuilder(),
            MaterialMasterTileBuilder(),
            MaterialListTileBuilder(),
          },
          bundles: {
            MaterialIcons(),
          },
        );
}
