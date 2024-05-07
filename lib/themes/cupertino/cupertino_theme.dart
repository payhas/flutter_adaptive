import 'package:flutter_adaptive/flutter_adaptive.dart';
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
            CupertinoIconButtonBuilder(),
            CupertinoSliderBuilder(),
            CupertinoCheckbox(),
            CupertinoSwitchBuilder(),
          },
        );
}
