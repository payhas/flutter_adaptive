import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveSwitch extends AdaptiveWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
}
