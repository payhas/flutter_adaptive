import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoModalDialogActionBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialogAction> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialogAction widget) {
    return CupertinoButton(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
