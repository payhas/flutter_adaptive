import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_fluent_ui/flutter_adaptive_fluent_ui.dart';

class FluentUITheme extends AdaptiveBundle {
  FluentUITheme()
      : super(builders: {
          FluentUIAppBuilder(),
          FluentUITextBuilder(),
          FluentUITextInputBuilder(),
          FluentUITextButtonBuilder(),
          FluentUIElevatedButtonBuilder(),
          FluentUIIconButtonBuilder(),
          FluentUISliderBuilder(),
          FluentUICheckboxBuilder(),
          FluentUISwitchBuilder(),
          FluentUICircularProgressIndicatorBuilder(),
          FluentUILinearProgressIndicatorBuilder(),
          FluentUIDatePickerBuilder(),
          FluentUIModalDialogBuilder(),
          FluentUIContextMenuBuilder(),
          FluentUIPageBuilder(),
          FluentUIThemeDataBuilder(),
          FluentUIAppBarBuilder(),
          FluentUINavigationBuilder(),
          FluentUIMasterDetailBuilder(),
          FluentUIDetailPageBuilder(),
          FluentUIMasterTileBuilder(),
          FluentUIListTileBuilder(),
        }, bundles: {
          FluentUIIcons(),
        });
}
