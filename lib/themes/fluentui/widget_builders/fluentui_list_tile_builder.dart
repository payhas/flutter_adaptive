import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIListTileBuilder extends AdaptiveWidgetBuilder<AdaptiveListTile> {
  @override
  Widget build(BuildContext context, AdaptiveListTile component) {
    return ListTile(
      leading: component.leading,
      title: component.title,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onPressed: component.onTap,
    );
  }
}
