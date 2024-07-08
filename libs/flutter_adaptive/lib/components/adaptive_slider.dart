import 'package:flutter/foundation.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveSlider extends AdaptiveWidget {
  const AdaptiveSlider(
      {super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double>? onChanged;
}
