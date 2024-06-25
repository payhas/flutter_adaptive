import 'package:flutter/material.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/components/adaptive_page.dart';
import 'package:yaru/widgets.dart';

class YaruPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return Scaffold(
      body: component.body,
      appBar: component.appBar?.build(context) as YaruWindowTitleBar?,
      bottomNavigationBar: component.bottomBar,
    );
  }
}
