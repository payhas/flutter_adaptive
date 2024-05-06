import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentUITextBuilder extends AdaptiveWidgetBuilder<AdaptiveText> {
  @override
  Widget build(BuildContext context, AdaptiveText widget) {
    return Text(
      widget.data,
    );
  }
}
