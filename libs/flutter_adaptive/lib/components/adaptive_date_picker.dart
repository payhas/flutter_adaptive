import 'package:flutter/foundation.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveDatePicker extends AdaptiveWidget {
  const AdaptiveDatePicker({
    super.key,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.onDateTimeChanged,
  });

  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final ValueChanged<DateTime> onDateTimeChanged;
}
