import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialDatePickerBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDatePicker> {
  Future<void> _selectDate(
      BuildContext context,
      DateTime initialDate,
      DateTime firstDate,
      DateTime lastDate,
      ValueChanged<DateTime> onDateTimeChanged) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (picked != null && picked != initialDate) {
      onDateTimeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context, AdaptiveDatePicker widget) {
    return ElevatedButton(
      onPressed: () => _selectDate(context, widget.initialDate, widget.minDate,
          widget.maxDate, widget.onDateTimeChanged),
      child: Text("${widget.initialDate.toLocal()}".split(' ')[0]),
    );
  }
}
