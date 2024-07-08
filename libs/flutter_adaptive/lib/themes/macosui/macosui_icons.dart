import '../../flutter_adaptive.dart';

class MacosUIIcons extends AdaptiveBundle {
  MacosUIIcons()
      : super(
          builderSelectors: {
            MacosUIIconBuilderSelector(),
          },
        );
}

class MacosUIIconBuilderSelector extends AdaptiveComponentBuilderSelector {
  @override
  AdaptiveComponentBuilder<AdaptiveComponent, dynamic>? select(
      String componentName,
      Set<AdaptiveComponentBuilder<AdaptiveComponent, dynamic>>? componentList,
      Map<String, dynamic> appearance) {
    if (componentName.startsWith(AdaptiveIcon.namePrefix)) {
      String? theme = appearance[ThemedAppearanceManager.themeAppearanceName];
      if (theme == 'MacosUI') {
        return componentList
            ?.where((builder) => builder.name.startsWith('Cupertino'))
            .lastOrNull;
      }
    }

    return null;
  }
}
