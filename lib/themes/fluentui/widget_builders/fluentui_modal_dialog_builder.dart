import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return fluentuiDialog(
          context,
          component.title,
          component.content,
          component.primaryButton,
          component.secondaryButton,
        );
      },
    );
  }
}

Widget fluentuiDialog(
  BuildContext context,
  Widget title,
  Widget content,
  AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
) {
  return ContentDialog(
    title: title,
    content: content,
    actions: [
      FilledButton(
        onPressed: primaryButton.onPressed,
        child: primaryButton.child,
      ),
      if (secondaryButton != null)
        Button(
          onPressed: secondaryButton.onPressed,
          child: secondaryButton.child,
        ),
    ],
  );
}
