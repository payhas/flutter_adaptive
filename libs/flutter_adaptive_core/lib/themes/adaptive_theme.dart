import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveTheme extends AdaptiveBundle {
  AdaptiveTheme({
    String defaultTheme = 'Material',
  }) : super(
          appearanceManagers: {
            ThemedAppearanceManager(
              defaultTheme: defaultTheme,
            ),
          },
          builderSelectors: {
            ThemedWidgetBuilderSelector(),
          },
          bundles: {
            CupertinoTheme(),
            MaterialTheme(),
          },
        );
}
