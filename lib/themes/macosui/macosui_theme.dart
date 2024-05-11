import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUITheme extends AdaptiveBundle {
  MacosUITheme()
      : super(
          widgetBuilders: {
            MacosUIAdaptiveAppBuilder(),
            MacosUITextBuilder(),
            MacosUITextInputBuilder(),
            MacosUIElevatedButtonBuilder(),
            MacosUIIconButtonBuilder(),
            MacosUICheckboxBuilder(),
            MacosUISwitchBuilder(),
            MacosUICircularProgressIndicatorBuilder(),
            MacosUILinearProgressIndicatorBuilder(),
          },
        );
}
