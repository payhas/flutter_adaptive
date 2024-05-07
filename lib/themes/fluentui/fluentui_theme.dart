import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/fluentui_switch_builder.dart';

class FluentUITheme extends AdaptiveBundle {
  FluentUITheme()
      : super(
          widgetBuilders: {
            FluentUIAdaptiveAppBuilder(),
            FluentUITextBuilder(),
            FluentUITextInputBuilder(),
            FluentUITextButtonBuilder(),
            FluentUIElevatedButtonBuilder(),
            FluentUIIconButtonBuilder(),
            FluentUISliderBuilder(),
            FluentUICheckboxBuilder(),
            FluentUISwitchBuilder(),
          },
        );
}
