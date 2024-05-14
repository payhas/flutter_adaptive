import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUITheme extends AdaptiveBundle {
  FluentUITheme()
      : super(
          builders: {
            FluentUIAppBuilder(),
            FluentUITextBuilder(),
            FluentUITextInputBuilder(),
            FluentUITextButtonBuilder(),
            FluentUIElevatedButtonBuilder(),
            FluentUIIconButtonBuilder(),
            FluentUISliderBuilder(),
            FluentUICheckboxBuilder(),
            FluentUISwitchBuilder(),
            FluentUICircularProgressIndicatorBuilder(),
            FluentUILinearProgressIndicatorBuilder(),
            FluentUIDatePickerBuilder(),
            FluentUIModalDialogBuilder(),
            FluentUIContextMenuItemBuilder(),
            FluentUIContextMenuBuilder(),
          },
        );
}
