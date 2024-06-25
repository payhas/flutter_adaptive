import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  Widget build(BuildContext context, AdaptiveAppBar component) {
    return Row(
      children: [
        component.leading ?? const SizedBox.shrink(),
        Expanded(
          child: CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: component.actions?.map((action) {
                    return CommandBarButton(
                        onPressed: action.onPressed,
                        icon: action.icon,
                        label: action.label);
                  }).toList() ??
                  []),
        ),
      ],
    );
  }
}
