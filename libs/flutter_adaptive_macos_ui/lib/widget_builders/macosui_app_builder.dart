import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUIAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    // ToDo - If new fields added to AdaptiveThemeData, add new fields to here (copyWith)
    MacosThemeData? data = (component.darkTheme == null)
        ? null
        : MacosThemeData.dark()
            .copyWith(brightness: component.darkTheme?.brightness);

    var shortCuts = (component.shortcuts is Map<LogicalKeySet, Intent>)
        ? component.shortcuts as Map<LogicalKeySet, Intent>
        : null;

    return MacosApp(
      theme: component.theme?.build(context),
      home: component.home,
      debugShowCheckedModeBanner: component.debugShowCheckedModeBanner,
      navigatorKey: component.navigatorKey,
      routes: component.routes ?? const <String, WidgetBuilder>{},
      initialRoute: component.initialRoute,
      onGenerateRoute: component.onGenerateRoute,
      onGenerateInitialRoutes: component.onGenerateInitialRoutes,
      onUnknownRoute: component.onUnknownRoute,
      navigatorObservers:
          component.navigatorObservers ?? const <NavigatorObserver>[],
      builder: component.builder,
      title: component.title,
      onGenerateTitle: component.onGenerateTitle,
      color: component.color,
      locale: component.locale,
      localizationsDelegates: component.localizationsDelegates,
      localeListResolutionCallback: component.localeListResolutionCallback,
      localeResolutionCallback: component.localeResolutionCallback,
      supportedLocales: component.supportedLocales,
      showPerformanceOverlay: component.showPerformanceOverlay,
      checkerboardRasterCacheImages: component.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: component.checkerboardOffscreenLayers,
      showSemanticsDebugger: component.showSemanticsDebugger,
      shortcuts: shortCuts,
      actions: component.actions,
      restorationScopeId: component.restorationScopeId,
      scrollBehavior: component.scrollBehavior ?? const MacosScrollBehavior(),
      darkTheme: data,
      themeMode: component.themeMode,
    );
  }
}
