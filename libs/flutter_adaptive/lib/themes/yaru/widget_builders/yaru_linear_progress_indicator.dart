import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';
import 'package:yaru/widgets.dart';

class YaruLinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    double progress = (((widget.value?.toInt())?.abs() ?? 0) % 100);
    return YaruLinearProgressIndicator(
      value: progress / 100,
    );
  }
}
