import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

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
