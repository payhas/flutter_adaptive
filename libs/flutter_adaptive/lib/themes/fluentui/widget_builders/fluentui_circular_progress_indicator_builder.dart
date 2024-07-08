import 'package:fluent_ui/fluent_ui.dart';
import '../../../flutter_adaptive.dart';

class FluentUICircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    return ProgressRing(
      value: widget.value,
    );
  }
}
