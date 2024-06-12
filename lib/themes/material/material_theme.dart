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
            MaterialScaffoldBuilder(),
            MaterialThemeDataBuilder(),
            MaterialAppBarBuilder(),
            MaterialNavigationBarBuilder(),
            MaterialNavigationBuilder(),
            MaterialMasterDetailBuilder(),
            MaterialDetailPageBuilder(),
          },
          bundles: {
            MaterialIcons(),
          },
        );
}
