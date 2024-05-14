import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruTheme extends AdaptiveBundle {
  YaruTheme()
      : super(
          widgetBuilders: {
            YaruAdaptiveAppBuilder(),
            YaruTextBuilder(),
            YaruTextInputBuilder(),
            YaruTextButtonBuilder(),
            YaruElevatedButtonBuilder(),
            YaruIconButtonBuilder(),
            YaruSliderBuilder(),
            YaruCheckboxBuilder(),
            YaruSwitchBuilder(),
            YaruCircularProgressIndicatorBuilder(),
            YaruLinearProgressIndicatorBuilder(),
            YaruDatePickerBuilder(),
            YaruModalDialogBuilder(),
            YaruModalBottomSheetBuilder(),
            YaruContextMenuItemBuilder(),
            YaruContextMenuBuilder(),
          },
        );
}
