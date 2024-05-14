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
          widgetBuilderSelectors: {
            ThemedWidgetBuilderSelector(),
          },
          functionInvokerSelectors: {
            ThemedFunctionInvokerSelector(),
          },
          bundles: {
            MaterialTheme(),
            CupertinoTheme(),
            FluentUITheme(),
            YaruTheme(),
          },
        );
}
