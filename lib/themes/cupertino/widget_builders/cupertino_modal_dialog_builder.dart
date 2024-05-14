import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return CupertinoAlertDialog(
      title: widget.title,
      content: widget.content,
      actions: <CupertinoDialogAction>[
        if (widget.secondaryButton != null)
          CupertinoDialogAction(
            onPressed: widget.secondaryButton!.onPressed,
            child: widget.secondaryButton!.child,
          ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: widget.primaryButton.onPressed,
          child: widget.primaryButton.child,
        ),
      ],
    );
  }
}
