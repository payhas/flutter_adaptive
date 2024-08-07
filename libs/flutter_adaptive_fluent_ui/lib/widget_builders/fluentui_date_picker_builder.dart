import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentUIDatePickerBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDatePicker> {
  @override
  Widget build(BuildContext context, AdaptiveDatePicker widget) {
    return DatePicker(
        startDate: widget.minDate,
        endDate: widget.maxDate,
        selected: widget.initialDate,
        onChanged: widget.onDateTimeChanged);
  }
}
