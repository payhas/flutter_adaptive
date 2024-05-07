import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialAdaptiveAppBuilder(),
            MaterialTextBuilder(),
            MaterialTextInputBuilder(),
            MaterialTextButtonBuilder(),
            MaterialElevatedButtonBuilder(),
            MaterialIconButtonBuilder(),
            MaterialSliderBuilder(),
            MaterialCheckboxBuilder(),
          },
        );
}
