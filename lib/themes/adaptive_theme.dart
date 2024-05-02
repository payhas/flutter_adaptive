import '../base/adaptive_bundle.dart';

import 'themed_appearance_manager.dart';
import 'themed_widget_builder_selector.dart';

import 'material/material_theme.dart';
import 'cupertino/cupertino_theme.dart';

class AdaptiveTheme extends AdaptiveBundle {
  AdaptiveTheme({
    String defaultTheme = 'Material',
  }) : super(
          appearanceManagers: {
            ThemedAppearanceManager(
              defaultTheme: defaultTheme,
            ),
          },
          widgetBuilderSelectors: {
            ThemedWidgetBuilderSelector(),
          },
          bundles: {
            MaterialTheme(),
            CupertinoTheme(),
          },
        );
}
