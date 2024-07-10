import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIDatePickerBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDatePicker> {
  void _showDialog(BuildContext context, Widget child) {
    showMacosAlertDialog<void>(
      context: context,
      builder: (BuildContext context) => MacosAlertDialog(
        appIcon: const FlutterLogo(
          size: 56,
        ),
        title: const Text("Choose a date"),
        message: child,
        primaryButton: PushButton(
          controlSize: ControlSize.large,
          onPressed: Navigator.of(context).pop,
          child: const Text("OK"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, AdaptiveDatePicker widget) {
    return PushButton(
        controlSize: ControlSize.large,
        onPressed: () => _showDialog(
              context,
              MacosDatePicker(
                  style: DatePickerStyle.graphical,
                  initialDate: widget.initialDate,
                  onDateChanged: widget.onDateTimeChanged),
            ),
        child: Text("${widget.initialDate.toLocal()}".split(' ')[0]));
  }
}
