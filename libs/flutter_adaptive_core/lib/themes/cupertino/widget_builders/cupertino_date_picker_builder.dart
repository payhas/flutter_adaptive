import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class CupertinoDatePickerBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDatePicker> {
  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, AdaptiveDatePicker widget) {
    return CupertinoButton(
        onPressed: () => _showDialog(
              context,
              CupertinoDatePicker(
                  initialDateTime: widget.initialDate,
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: widget.minDate,
                  maximumDate: widget.maxDate,
                  onDateTimeChanged: widget.onDateTimeChanged),
            ),
        child: Text("${widget.initialDate.toLocal()}".split(' ')[0]));
  }
}
