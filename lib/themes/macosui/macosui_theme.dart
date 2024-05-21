import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUITheme extends AdaptiveBundle {
  MacosUITheme()
      : super(
          builders: {
            MacosUIAdaptiveAppBuilder(),
            MacosUITextBuilder(),
            MacosUITextInputBuilder(),
            MacosUITextButtonBuilder(),
            MacosUIElevatedButtonBuilder(),
            MacosUIIconButtonBuilder(),
            MacosUISliderBuilder(),
            MacosUICheckboxBuilder(),
            MacosUISwitchBuilder(),
            MacosUICircularProgressIndicatorBuilder(),
            MacosUILinearProgressIndicatorBuilder(),
            MacosUIDatePickerBuilder(),
            MacosUIModalDialogBuilder(),
            MacosUIContextMenuBuilder(),
            MacosUIScaffoldBuilder(),
            MacosUIThemeDataBuilder(),
            MacosUIAppBarBuilder(),
          },
        );
}
