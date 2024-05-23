import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return NavigationView(
      appBar: mapAppBar(component.appBar),
      content: component.body,
    );
  }

  mapAppBar(AdaptiveAppBar? appBar) {
    return NavigationAppBar(
      title: appBar?.title,
    );
  }
}
