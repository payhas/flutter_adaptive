import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/common/adaptive_app.dart';

class FluentUIAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return FluentApp(
      home: widget.home,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
}
