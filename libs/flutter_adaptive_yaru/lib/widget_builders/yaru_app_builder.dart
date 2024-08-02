import 'package:flutter/material.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter_adaptive_yaru/widget_builders/yaru_theme_data_builder.dart';
import 'package:yaru/yaru.dart';

class YaruAdaptiveAppBuilder extends AdaptiveWidgetBuilder<AdaptiveApp> {
  @override
  Widget build(BuildContext context, AdaptiveApp component) {
    // ToDo - If new fields added to AdaptiveThemeData, add new fields to here (copyWith)
    ThemeData? data = (component.darkTheme == null)
        ? null
        : ThemeData.dark()
            .copyWith(brightness: component.darkTheme?.brightness);

    return YaruTheme(
      builder: (context, yaru, child) {
        YaruThemeDataBuilder.yaruThemeData = yaru;
        return MaterialApp(
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
          checkerboardRasterCacheImages:
              component.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: component.checkerboardOffscreenLayers,
          showSemanticsDebugger: component.showSemanticsDebugger,
          shortcuts: component.shortcuts,
          actions: component.actions,
          restorationScopeId: component.restorationScopeId,
          scrollBehavior: component.scrollBehavior,
          darkTheme: data,
          themeMode: component.themeMode,
        );
      },
    );
  }
}
