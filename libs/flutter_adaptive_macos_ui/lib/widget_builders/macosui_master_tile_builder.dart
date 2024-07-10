import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter/cupertino.dart';
import 'master_detail/master_detail_library.dart';

class MacosUIMasterTileBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterTile> {
  @override
  Widget build(BuildContext context, AdaptiveMasterTile component) {
    return MacosUIMasterTile(
      selected: component.selected,
      leading: component.leading,
      title: component.title,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onTap: component.onTap,
    );
  }
}
