import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIAppBarBuilder extends AdaptiveAppBarBuilder {
  @override
  TitleBar? build(BuildContext context, AdaptiveAppBar component) {
    return TitleBar(title: component.title);
  }
}
