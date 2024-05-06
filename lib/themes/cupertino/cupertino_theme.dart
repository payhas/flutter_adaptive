import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/cupertino_text_button_builder.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/cupertino_text_input_builder.dart';
import 'package:flutter_adaptive/themes/cupertino/widget_builders/cupertino_switch_builder.dart';

class CupertinoTheme extends AdaptiveBundle {
  CupertinoTheme()
      : super(
          widgetBuilders: {
            CupertinoAdaptiveAppBuilder(),
            CupertinoTextBuilder(),
            CupertinoTextInputBuilder(),
            CupertinoTextButtonBuilder(),
            CupertinoElevatedButtonBuilder(),
            CupertinoSwitchBuilder(),
          },
        );
}
