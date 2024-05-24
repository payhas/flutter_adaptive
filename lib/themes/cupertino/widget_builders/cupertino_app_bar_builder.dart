import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  CupertinoNavigationBar build(BuildContext context, AdaptiveAppBar component) {
    return CupertinoNavigationBar(
      middle: component.title,
      backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
    );
  }
}
