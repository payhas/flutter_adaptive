import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return Scaffold(
      appBar: component.appBar?.build(context) as AppBar?,
      bottomNavigationBar: component.navigationBar,
      body: component.body,
    );
  }
}
