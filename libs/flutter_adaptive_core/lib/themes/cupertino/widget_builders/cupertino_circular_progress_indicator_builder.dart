import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoCircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    return (widget.value == null)
        ? const CupertinoActivityIndicator()
        : CupertinoActivityIndicator.partiallyRevealed(
            progress: widget.value!,
          );
  }
}
