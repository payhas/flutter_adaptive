import 'package:flutter/cupertino.dart';

import '../../../base/adaptive_widget_builder.dart';
import '../../../common/adaptive_button.dart';

class CupertinoButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveButton> {
  @override
  Widget build(BuildContext context, AdaptiveButton widget) {
    return CupertinoButton.filled(
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
