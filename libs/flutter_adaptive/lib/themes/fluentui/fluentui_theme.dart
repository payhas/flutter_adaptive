import '../../flutter_adaptive.dart';

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
