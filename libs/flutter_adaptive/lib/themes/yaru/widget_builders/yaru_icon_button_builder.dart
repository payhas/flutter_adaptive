import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';
import 'package:yaru/widgets.dart';

class YaruIconButtonBuilder extends AdaptiveWidgetBuilder<AdaptiveIconButton> {
  @override
  Widget build(BuildContext context, AdaptiveIconButton widget) {
    return YaruIconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
    );
  }
}
