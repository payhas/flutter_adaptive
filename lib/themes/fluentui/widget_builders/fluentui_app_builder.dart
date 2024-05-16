import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/common/adaptive_app.dart';

class FluentUIAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return FluentApp(
      theme: FluentThemeData(brightness: widget.theme?.brightness),
      home: widget.home,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
}
