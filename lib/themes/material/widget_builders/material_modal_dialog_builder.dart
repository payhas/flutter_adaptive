import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return AlertDialog(
      title: widget.title,
      content: widget.content,
      actions: <Widget>[
        if (widget.secondaryButton != null)
          TextButton(
            onPressed: widget.secondaryButton!.onPressed,
            child: widget.secondaryButton!.child,
          ),
        TextButton(
          onPressed: widget.primaryButton.onPressed,
          child: widget.primaryButton.child,
        ),
      ],
    );
  }
}
