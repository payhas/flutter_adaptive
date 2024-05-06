import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/material_text_input_builder.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialAdaptiveAppBuilder(),
            MaterialTextBuilder(),
            MaterialTextInputBuilder(),
            MaterialElevatedButtonBuilder(),
          },
        );
}
