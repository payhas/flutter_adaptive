import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive/base/adaptive_widget.dart';

class AdaptiveModalDialog extends AdaptiveWidget {
  const AdaptiveModalDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
  });

  final Widget? title;

  final Widget? content;

  final List<Widget>? actions;
}
