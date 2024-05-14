import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return ContentDialog(
      title: widget.title,
      content: widget.content,
      actions: [
        FilledButton(
          onPressed: widget.primaryButton.onPressed,
          child: widget.primaryButton.child,
        ),
        if (widget.secondaryButton != null)
          Button(
            onPressed: widget.secondaryButton!.onPressed,
            child: widget.secondaryButton!.child,
          ),
      ],
    );
  }
}
