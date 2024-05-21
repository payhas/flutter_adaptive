import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIAppBarBuilder extends AdaptiveAppBarBuilder {
  @override
  NavigationAppBar? build(BuildContext context, AdaptiveAppBar component) {
    return NavigationAppBar(title: component.title);
  }
}
