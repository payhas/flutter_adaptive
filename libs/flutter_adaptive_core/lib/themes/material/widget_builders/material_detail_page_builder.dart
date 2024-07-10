import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter/widgets.dart';
import 'master_detail/master_detail_library.dart';

class MaterialDetailPageBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDetailPage> {
  @override
  Widget build(BuildContext context, AdaptiveDetailPage component) {
    return MaterialDetailPage(
      appBarActions: component.appBarActions,
      appBarTitle: component.appBarTitle,
      body: component.body,
      backgroundColor: component.backgroundColor,
    );
  }
}
