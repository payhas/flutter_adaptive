import 'package:flutter_adaptive_macos_ui/flutter_adaptive_macos_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUITheme extends AdaptiveBundle {
  MacosUITheme()
      : super(builders: {
          MacosUIAdaptiveAppBuilder(),
          MacosUITextBuilder(),
          MacosUITextInputBuilder(),
          MacosUITextButtonBuilder(),
          MacosUIElevatedButtonBuilder(),
          MacosUIIconButtonBuilder(),
          MacosUISliderBuilder(),
          MacosUICheckboxBuilder(),
          MacosUISwitchBuilder(),
          MacosUICircularProgressIndicatorBuilder(),
          MacosUILinearProgressIndicatorBuilder(),
          MacosUIDatePickerBuilder(),
          MacosUIModalDialogBuilder(),
          MacosUIContextMenuBuilder(),
          MacosUIPageBuilder(),
          MacosUIThemeDataBuilder(),
          MacosUIAppBarBuilder(),
          MacosUINavigationBuilder(),
          MacosUIMasterDetailBuilder(),
          MacosUIDetailPageBuilder(),
          MacosUIMasterTileBuilder(),
          MacosUIListTileBuilder(),
        }, bundles: {
          MacosUIIcons(),
        });
}
