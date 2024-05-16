import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class YaruScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return Scaffold(body: component.body);
  }
}
