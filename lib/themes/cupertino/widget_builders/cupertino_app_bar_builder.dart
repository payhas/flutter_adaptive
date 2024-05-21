import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoAppBarBuilder extends AdaptiveAppBarBuilder {
  @override
  CupertinoNavigationBar? build(
      BuildContext context, AdaptiveAppBar component) {
    return CupertinoNavigationBar(middle: component.title);
  }
}
