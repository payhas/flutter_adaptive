import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/material_circular_progress_indicator_builder.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/material_text_button_builder.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/material_text_input_builder.dart';
import 'package:flutter_adaptive/themes/material/widget_builders/material_switch_builder.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialAdaptiveAppBuilder(),
            MaterialTextBuilder(),
            MaterialTextInputBuilder(),
            MaterialTextButtonBuilder(),
            MaterialElevatedButtonBuilder(),
            MaterialSwitchBuilder(),
            MaterialCircularProgressIndicatorBuilder(),
          },
        );
}
