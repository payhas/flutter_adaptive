import 'package:fluent_ui/fluent_ui.dart';
import '../../../flutter_adaptive.dart';

class FluentUICheckboxBuilder extends AdaptiveWidgetBuilder<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context, AdaptiveCheckbox widget) {
    return Checkbox(checked: widget.value, onChanged: widget.onChanged);
  }
}
