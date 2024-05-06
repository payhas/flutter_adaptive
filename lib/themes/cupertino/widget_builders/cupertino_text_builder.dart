import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoTextBuilder extends AdaptiveWidgetBuilder<AdaptiveText> {
  @override
  Widget build(BuildContext context, AdaptiveText widget) {
    return Text(
      widget.data,
    );
  }
}
