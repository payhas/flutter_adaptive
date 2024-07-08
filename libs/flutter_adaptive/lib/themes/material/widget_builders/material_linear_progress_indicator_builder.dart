import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialLinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    double progress = (((widget.value?.toInt())?.abs() ?? 0) % 100);
    return LinearProgressIndicator(
      value: progress / 100,
    );
  }
}
