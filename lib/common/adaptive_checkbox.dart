import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/base/adaptive_widget.dart';

class AdaptiveCheckbox extends AdaptiveWidget {
  const AdaptiveCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
}
