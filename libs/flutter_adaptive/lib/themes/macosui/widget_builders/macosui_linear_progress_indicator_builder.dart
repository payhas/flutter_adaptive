import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../flutter_adaptive.dart';

class MacosUILinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    return ProgressBar(
      value: widget.value ?? 0,
    );
  }
}
