import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/fluentui_circular_progress_indicator_builder.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/fluentui_switch_builder.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/fluentui_text_button_builder.dart';
import 'package:flutter_adaptive/themes/fluentui/widget_builders/fluentui_text_input_builder.dart';

class FluentUITheme extends AdaptiveBundle {
  FluentUITheme()
      : super(
          widgetBuilders: {
            FluentUIAdaptiveAppBuilder(),
            FluentUITextBuilder(),
            FluentUITextInputBuilder(),
            FluentUITextButtonBuilder(),
            FluentUIElevatedButtonBuilder(),
            FluentUISwitchBuilder(),
            FluentUICircularProgressIndicatorBuilder(),
          },
        );
}
