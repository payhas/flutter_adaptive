import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:yaru/widgets.dart';

class YaruPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return Scaffold(
      body: component.child,
      appBar: component.appBar?.build(context) as YaruWindowTitleBar?,
      bottomNavigationBar: component.bottomBar,
    );
  }
}
