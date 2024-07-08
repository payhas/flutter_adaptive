import '../../../flutter_adaptive.dart';
import 'package:flutter/cupertino.dart';
import 'master_detail/master_detail_library.dart';

class MaterialMasterTileBuilder
    extends AdaptiveWidgetBuilder<AdaptiveMasterTile> {
  @override
  Widget build(BuildContext context, AdaptiveMasterTile component) {
    return MaterialMasterTile(
      selected: component.selected,
      leading: component.leading,
      title: component.title,
      subtitle: component.subtitle,
      trailing: component.trailing,
      onTap: component.onTap,
    );
  }
}
