import 'package:flutter/widgets.dart';

import '../base/adaptive_component_builder.dart';
import 'adaptive_icon.dart';

abstract class AdaptiveIconBuilder
    extends AdaptiveComponentBuilder<AdaptiveIcon, Icon> {
  @override
  String get name => '${super.name}_$componentName';
  @override
  String get componentName => AdaptiveIcon.normalizeIconName(iconName);

  const AdaptiveIconBuilder(
    this.iconName,
    this.iconData,
  );

  final String iconName;
  final IconData iconData;

  @override
  Icon build(BuildContext context, AdaptiveIcon component) {
    return Icon(
      iconData,
      size: component.size,
      fill: component.fill,
      weight: component.weight,
      grade: component.grade,
      opticalSize: component.opticalSize,
      color: component.color,
      shadows: component.shadows,
      semanticLabel: component.semanticLabel,
      textDirection: component.textDirection,
      applyTextScaling: component.applyTextScaling,
    );
  }
}
