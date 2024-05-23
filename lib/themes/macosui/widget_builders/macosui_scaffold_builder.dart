import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return MacosWindow(
      titleBar: component.appBar?.build(context) as dynamic,
      child: component.body,
    );
  }
}
