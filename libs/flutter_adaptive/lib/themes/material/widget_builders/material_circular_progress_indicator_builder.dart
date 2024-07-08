import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class MaterialCircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    return CircularProgressIndicator(
      value: widget.value,
    );
  }
}
