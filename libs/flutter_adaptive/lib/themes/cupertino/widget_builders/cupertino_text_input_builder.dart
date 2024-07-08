import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

class CupertinoTextInputBuilder
    extends AdaptiveWidgetBuilder<AdaptiveTextInput> {
  @override
  Widget build(BuildContext context, AdaptiveTextInput widget) {
    return CupertinoTextField(
      placeholder: widget.placeholder,
    );
  }
}
