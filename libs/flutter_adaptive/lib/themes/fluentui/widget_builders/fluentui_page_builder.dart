import 'package:fluent_ui/fluent_ui.dart';
import '../../../flutter_adaptive.dart';

class FluentUIPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return Column(
      children: [
        component.appBar?.build(context) ?? const SizedBox.shrink(),
        Expanded(child: component.child),
        component.bottomBar ?? const SizedBox.shrink(),
      ],
    );
  }
}
