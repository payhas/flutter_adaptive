import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveSwitch extends AdaptiveWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
}
