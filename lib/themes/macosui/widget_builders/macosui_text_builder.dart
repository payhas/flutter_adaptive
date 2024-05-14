import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUITextBuilder extends AdaptiveWidgetBuilder<AdaptiveText> {
  @override
  Widget build(BuildContext context, AdaptiveText widget) {
    return Text(
      widget.data,
    );
  }
}
