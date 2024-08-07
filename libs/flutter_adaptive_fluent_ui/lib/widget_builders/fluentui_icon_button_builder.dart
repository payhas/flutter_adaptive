import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUIIconButtonBuilder
    extends AdaptiveWidgetBuilder<AdaptiveIconButton> {
  @override
  Widget build(BuildContext context, AdaptiveIconButton widget) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
    );
  }
}
