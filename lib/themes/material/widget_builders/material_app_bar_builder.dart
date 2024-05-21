import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialAppBarBuilder extends AdaptiveAppBarBuilder {
  @override
  AppBar? build(BuildContext context, AdaptiveAppBar component) {
    return AppBar(title: component.title);
  }
}
