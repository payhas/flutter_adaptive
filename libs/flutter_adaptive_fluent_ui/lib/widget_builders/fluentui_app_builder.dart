import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class FluentUIAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    return FluentApp(
      theme: component.theme?.build(context),
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
    );
  }
}
