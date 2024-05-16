import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide YaruTheme;
import 'package:yaru/yaru.dart';

class YaruAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp widget) {
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        theme: widget.theme?.brightness == Brightness.light
            ? yaru.theme
            : yaru.darkTheme,
        home: widget.home,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      );
    });
  }
}
