import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialAppBarBuilder extends AdaptiveWidgetBuilder<AdaptiveAppBar> {
  @override
  AppBar build(BuildContext context, AdaptiveAppBar component) {
    return AppBar(title: component.title);
  }
}
