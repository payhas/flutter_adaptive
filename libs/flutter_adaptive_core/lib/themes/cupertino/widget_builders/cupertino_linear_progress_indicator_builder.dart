import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoLinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    double progress = (((widget.value?.toInt())?.abs() ?? 0) % 100);
    return LinearProgressIndicator(
      color: CupertinoColors.systemGreen,
      backgroundColor: CupertinoColors.secondarySystemFill,
      value: progress / 100,
    );
  }
}
