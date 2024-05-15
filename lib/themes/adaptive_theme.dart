import 'package:flutter_adaptive/flutter_adaptive.dart';

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
            FluentUITheme(),
            YaruTheme(),
            MaterialTheme(),
          },
        );
}
