import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIModalDialogBuilder
    extends AdaptiveWidgetBuilder<AdaptiveModalDialog> {
  @override
  Widget build(BuildContext context, AdaptiveModalDialog widget) {
    return ContentDialog(
      title: widget.title,
      content: widget.content,
      actions: widget.actions ??
          [
            FilledButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
    );
  }
}
