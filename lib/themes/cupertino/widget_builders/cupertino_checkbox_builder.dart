import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter/cupertino.dart';

class CupertinoCheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return CupertinoCheckbox(value: widget.value, onChanged: widget.onChanged);
  }
}
