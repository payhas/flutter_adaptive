import 'package:flutter/widgets.dart';
import '../base/adaptive_widget.dart';

class AdaptiveSwitch extends AdaptiveWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
}
