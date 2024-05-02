import '../../base/adaptive_bundle.dart';

import 'widget_builders/cupertino_button_builder.dart';

class CupertinoTheme extends AdaptiveBundle {
  CupertinoTheme()
      : super(
          widgetBuilders: {
            CupertinoButtonBuilder(),
          },
        );
}
