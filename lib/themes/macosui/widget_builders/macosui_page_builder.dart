import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUIPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return MacosScaffold(
      toolBar: component.appBar?.build(context) as ToolBar?,
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Column(
              children: [
                Expanded(child: component.child),
                component.bottomBar ?? const SizedBox.shrink() ,
              ],
            );
          },
        ),
      ],
    );
  }
}
