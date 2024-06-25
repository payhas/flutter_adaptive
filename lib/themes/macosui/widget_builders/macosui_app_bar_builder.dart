import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  TitleBar build(BuildContext context, AdaptiveAppBar component) {
    return TitleBar(
      height: 52.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          component.leading ?? const SizedBox.shrink(),
          component.title ?? const SizedBox.shrink(),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
