import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MacosUIIconButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveIconButton> {
  @override
  Widget build(BuildContext context, AdaptiveIconButton widget) {
    return MacosIconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
    );
  }
}
