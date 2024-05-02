import '../../base/adaptive_bundle.dart';

import 'widget_builders/material_button_builder.dart';

class MaterialTheme extends AdaptiveBundle {
  MaterialTheme()
      : super(
          widgetBuilders: {
            MaterialButtonBuilder(),
          },
        );
}
