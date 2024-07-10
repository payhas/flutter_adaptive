import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_fluent_ui/flutter_adaptive_fluent_ui.dart';
import 'package:flutter_adaptive_macos_ui/flutter_adaptive_macos_ui.dart';
import 'package:flutter_adaptive_yaru/flutter_adaptive_yaru.dart';

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
            MacosUITheme(),
            MaterialTheme(),
          },
        );
}
