import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

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
