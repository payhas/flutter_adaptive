import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../flutter_adaptive.dart';

class MacosUICircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    return ProgressCircle(
      value: widget.value,
    );
  }
}
