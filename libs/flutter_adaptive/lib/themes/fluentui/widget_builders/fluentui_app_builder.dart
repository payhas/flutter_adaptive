import 'package:fluent_ui/fluent_ui.dart';
import '../../../base/adaptive_widget_builder.dart';
import '../../../components/adaptive_app.dart';

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
