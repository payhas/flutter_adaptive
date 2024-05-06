import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialTextBuilder extends AdaptiveWidgetBuilder<AdaptiveText> {
  @override
  Widget build(BuildContext context, AdaptiveText widget) {
    return Text(
      widget.data,
    );
  }
}
