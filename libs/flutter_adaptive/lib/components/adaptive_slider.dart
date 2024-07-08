import 'package:flutter/foundation.dart';
import '../base/adaptive_widget.dart';

class AdaptiveSlider extends AdaptiveWidget {
  const AdaptiveSlider(
      {super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double>? onChanged;
}
