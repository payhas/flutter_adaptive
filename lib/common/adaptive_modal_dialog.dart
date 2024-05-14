import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveModalDialog extends AdaptiveWidget {
  const AdaptiveModalDialog({
    super.key,
    this.title,
    this.content,
    required this.primaryButton,
    this.secondaryButton,
  });

  final Widget? title;

  final Widget? content;

  final AdaptiveModalDialogAction primaryButton;
  final AdaptiveModalDialogAction? secondaryButton;
}
