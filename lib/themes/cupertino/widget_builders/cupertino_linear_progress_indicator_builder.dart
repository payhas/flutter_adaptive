import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide CupertinoTheme;
import 'package:linear_progress_bar/linear_progress_bar.dart';

class CupertinoLinearProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveLinearProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveLinearProgressIndicator widget) {
    return LinearProgressBar(
      maxSteps: 100,
      progressType: LinearProgressBar.progressTypeLinear,
      currentStep: widget.value?.toInt(),
      progressColor: CupertinoColors.systemGreen,
      backgroundColor: CupertinoColors.secondarySystemFill,
    );
  }
}
