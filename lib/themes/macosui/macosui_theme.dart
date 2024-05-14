import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUITheme extends AdaptiveBundle {
  MacosUITheme()
      : super(
          widgetBuilders: {
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
            MacosUIModalDialogActionBuilder(),
          },
        );
}
