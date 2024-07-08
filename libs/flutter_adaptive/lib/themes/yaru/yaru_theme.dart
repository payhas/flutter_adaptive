import '../../flutter_adaptive.dart';
import 'widget_builders/yaru_page_builder.dart';

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
          YaruPageBuilder(),
          YaruThemeDataBuilder(),
          YaruAppBarBuilder(),
          YaruNavigationBuilder(),
          YaruMasterDetailBuilder(),
          YaruDetailPageBuilder(),
          YaruMasterTileBuilder(),
          YaruListTileBuilder(),
        }, bundles: {
          YaruIcons(),
        });
}
