import 'package:flutter_adaptive/flutter_adaptive.dart';

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
            CupertinoCircularProgressIndicatorBuilder(),
          },
        );
}
