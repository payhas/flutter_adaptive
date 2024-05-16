import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUIScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return Scaffold(
        body: component.body,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : null);
  }
}
