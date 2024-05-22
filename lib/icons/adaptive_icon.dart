import 'package:flutter/material.dart';

import '../base/adaptive.dart';
import '../base/adaptive_component.dart';

class AdaptiveIcon extends StatelessWidget with AdaptiveComponent<Icon> {
  @override
  String get name => normalizeIconName(iconName);

  const AdaptiveIcon(
    this.iconName, {
    super.key,
    this.size,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
    this.applyTextScaling,
  })  : assert(fill == null || (0.0 <= fill && fill <= 1.0)),
        assert(weight == null || (0.0 < weight)),
        assert(opticalSize == null || (0.0 < opticalSize));

  final String iconName;
  final double? size;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final Color? color;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final bool? applyTextScaling;

  @override
  Icon build(BuildContext context) {
    var builder = Adaptive.of(context)?.getBuilder<AdaptiveIcon, Icon>(this);
    return builder?.build(context, this) ??
        const Icon(Icons.report_gmailerrorred);
  }

  static String normalizeIconName(String iconName) {
    return 'icon_$iconName';
  }
}
