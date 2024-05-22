import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return CupertinoPageScaffold(
      navigationBar: component.appBar?.build(context) as dynamic,
      child: component.body ?? const SizedBox.shrink(),
    );
  }
}
