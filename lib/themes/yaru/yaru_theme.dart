import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruTheme extends AdaptiveBundle {
  YaruTheme()
      : super(builders: {
          YaruAdaptiveAppBuilder(),
          YaruTextBuilder(),
          YaruTextInputBuilder(),
          YaruTextButtonBuilder(),
          YaruElevatedButtonBuilder(),
          YaruIconButtonBuilder(),
          YaruSliderBuilder(),
          YaruCheckboxBuilder(),
          YaruSwitchBuilder(),
          YaruCircularProgressIndicatorBuilder(),
          YaruLinearProgressIndicatorBuilder(),
          YaruModalDialogBuilder(),
          YaruContextMenuBuilder(),
          YaruThemeDataBuilder(),
          YaruNavigationBuilder(),
        }, bundles: {
          YaruIcons(),
        });
}
