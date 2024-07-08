import 'package:flutter/cupertino.dart';
import '../../../flutter_adaptive.dart';

class MacosUIListTileBuilder extends AdaptiveWidgetBuilder<AdaptiveListTile> {
  @override
  Widget build(BuildContext context, AdaptiveListTile component) {
    return CupertinoListTile(
      leading: component.leading,
      title: component.title!,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onTap: component.onTap,
    );
  }
}
