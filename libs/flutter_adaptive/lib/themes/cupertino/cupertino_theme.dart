import '../../flutter_adaptive.dart';

class CupertinoTheme extends AdaptiveBundle {
  CupertinoTheme()
      : super(
          builders: {
            CupertinoAppBuilder(),
            CupertinoTextBuilder(),
            CupertinoTextInputBuilder(),
            CupertinoTextButtonBuilder(),
            CupertinoElevatedButtonBuilder(),
            CupertinoIconButtonBuilder(),
            CupertinoSliderBuilder(),
            CupertinoCheckboxBuilder(),
            CupertinoSwitchBuilder(),
            CupertinoCircularProgressIndicatorBuilder(),
            CupertinoLinearProgressIndicatorBuilder(),
            CupertinoDatePickerBuilder(),
            CupertinoModalDialogBuilder(),
            CupertinoModalBottomSheetBuilder(),
            CupertinoContextMenuItemBuilder(),
            CupertinoContextMenuBuilder(),
            CupertinoPageBuilder(),
            CupertinoThemeDataBuilder(),
            CupertinoAppBarBuilder(),
            CupertinoNavigationBuilder(),
            CupertinoMasterDetailBuilder(),
            CupertinoDetailPageBuilder(),
            CupertinoMasterTileBuilder(),
            CupertinoListTileBuilder(),
          },
          bundles: {
            CupertinoIcons(),
          },
        );
}
