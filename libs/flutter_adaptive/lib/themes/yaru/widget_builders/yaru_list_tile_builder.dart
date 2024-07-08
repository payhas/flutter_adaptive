import 'package:flutter/material.dart';
import '../../../flutter_adaptive.dart';

class YaruListTileBuilder extends AdaptiveWidgetBuilder<AdaptiveListTile> {
  @override
  Widget build(BuildContext context, AdaptiveListTile component) {
    return ListTile(
      leading: component.leading,
      title: component.title,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onTap: component.onTap,
    );
  }
}
