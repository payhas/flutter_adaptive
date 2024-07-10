import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MaterialTextBuilder extends AdaptiveWidgetBuilder<AdaptiveText> {
  @override
  Widget build(BuildContext context, AdaptiveText component) {
    return Text(
      component.data,
      style: component.style,
      strutStyle: component.strutStyle,
      textAlign: component.textAlign,
      textDirection: component.textDirection,
      locale: component.locale,
      softWrap: component.softWrap,
      overflow: component.overflow,
      textScaler: component.textScaler,
      maxLines: component.maxLines,
      semanticsLabel: component.semanticsLabel,
      textWidthBasis: component.textWidthBasis,
      textHeightBehavior: component.textHeightBehavior,
      selectionColor: component.selectionColor,
    );
  }
}
