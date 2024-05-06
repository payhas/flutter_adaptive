import '../../base/adaptive_bundle.dart';

import 'widget_builders/material_button_builder.dart';
import 'widget_builders/material_switch_builder.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialButtonBuilder(),
            MaterialSwitchBuilder(),
          },
        );
}
