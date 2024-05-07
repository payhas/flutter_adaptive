import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class CupertinoCheckbox extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return cupertino.CupertinoCheckbox(
        value: widget.value, onChanged: widget.onChanged);
  }
}
