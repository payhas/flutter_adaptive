import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return CupertinoPageScaffold(
        navigationBar: component.appBar?.build(context),
        child: Stack(children: [
          if (component.body != null) component.body!,
          if (component.navigationBar != null) ...[
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 100.0,
                child: SizedBox(height: 100.0)),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: component.navigationBar!)
          ]
        ]));
  }
}
