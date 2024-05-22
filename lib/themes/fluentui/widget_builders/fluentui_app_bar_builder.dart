import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  CommandBar build(BuildContext context, AdaptiveAppBar component) {
    return CommandBar(
      primaryItems: mapPrimaryItems(component),
    );
  }

  List<CommandBarItem> mapPrimaryItems(AdaptiveAppBar component) {
    var items = List<CommandBarItem>.empty();
    if (component.title != null) {
      items.add(CommandBarWidget(child: component.title!));
    }

    return items;
  }
}

class CommandBarWidget extends CommandBarItem {
  const CommandBarWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, CommandBarItemDisplayMode displayMode) {
    switch (displayMode) {
      case CommandBarItemDisplayMode.inPrimary:
      case CommandBarItemDisplayMode.inPrimaryCompact:
        return CommandBarItemInPrimary(
          child: child,
        );
      case CommandBarItemDisplayMode.inSecondary:
        return child;
    }
  }
}
