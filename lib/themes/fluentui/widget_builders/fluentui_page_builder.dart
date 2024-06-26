import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: component.appBar?.build(context) ?? const SizedBox.shrink(),
        ),
        Expanded(child: component.body),
        component.bottomBar ?? const SizedBox.shrink(),
      ],
    );
  }
}
