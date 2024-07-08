import '../../../flutter_adaptive.dart';
import 'package:flutter/cupertino.dart';
import 'master_detail/master_detail_library.dart';

class FluentUIDetailPageBuilder
    extends AdaptiveWidgetBuilder<AdaptiveDetailPage> {
  @override
  Widget build(BuildContext context, AdaptiveDetailPage component) {
    return FluentUIDetailPage(
      appBarActions: component.appBarActions,
      appBarTitle: component.appBarTitle,
      body: component.body,
      backgroundColor: component.backgroundColor,
    );
  }
}
