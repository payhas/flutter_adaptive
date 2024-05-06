import 'package:flutter_adaptive/flutter_adaptive.dart';

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
          },
        );
}
