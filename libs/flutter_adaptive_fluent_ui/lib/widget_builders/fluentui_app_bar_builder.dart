import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_fluent_ui/flutter_adaptive_fluent_ui.dart';
import 'master_detail/portrait_layout.dart';

class FluentUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  Widget build(BuildContext context, AdaptiveAppBar component) {
    return FluentUIAppBar(component: component);
  }
}

class FluentUIAppBar extends StatefulWidget {
  const FluentUIAppBar({super.key, required this.component});

  final AdaptiveAppBar component;

  @override
  FluentUIAppBarState createState() => FluentUIAppBarState();
}

class FluentUIAppBarState extends State<FluentUIAppBar> {
  FluentBackButtonNotifier? fluentBackButtonNotifier;

  @override
  void initState() {
    super.initState();

    FluentNavigationState? fluentNavigationState =
        context.findAncestorStateOfType<FluentNavigationState>();

    fluentBackButtonNotifier = fluentNavigationState?.fluentBackButtonNotifier;

    fluentBackButtonNotifier?.addListener(pop);
  }

  @override
  void dispose() {
    super.dispose();

    fluentBackButtonNotifier?.removeListener(pop);
  }

  void pop() {
    FluentUIPortraitDetailBuilderPage? fluentUIPortraitDetailBuilderPage =
        context
            .findAncestorWidgetOfExactType<FluentUIPortraitDetailBuilderPage>();

    if (fluentUIPortraitDetailBuilderPage != null) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          widget.component.leading ?? const SizedBox.shrink(),
          const SizedBox(width: 8.0),
          widget.component.title ?? const SizedBox.shrink(),
          Expanded(
            child: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: widget.component.actions?.map((action) {
                      return CommandBarButton(
                          onPressed: action.onPressed,
                          icon: action.icon,
                          label: action.label);
                    }).toList() ??
                    []),
          ),
        ],
      ),
    );
  }
}
