import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

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
