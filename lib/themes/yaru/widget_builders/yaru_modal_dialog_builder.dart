import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return AlertDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions ??
          <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
    );
  }
}
