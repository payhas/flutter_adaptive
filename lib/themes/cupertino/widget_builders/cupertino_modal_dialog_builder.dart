import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return CupertinoAlertDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions ??
          <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
    );
  }
}
