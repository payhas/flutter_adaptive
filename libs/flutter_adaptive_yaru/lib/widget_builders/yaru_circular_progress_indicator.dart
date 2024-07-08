import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:yaru/widgets.dart';

class YaruCircularProgressIndicatorBuilder
    extends AdaptiveWidgetBuilder<AdaptiveCircularProgressIndicator> {
  @override
  Widget build(BuildContext context, AdaptiveCircularProgressIndicator widget) {
    return YaruCircularProgressIndicator(
      value: widget.value,
    );
  }
}
