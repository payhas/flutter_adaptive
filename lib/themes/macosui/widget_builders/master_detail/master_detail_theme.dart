import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart'
    show ThemeExtension, PageTransitionsTheme;
import 'package:macos_ui/macos_ui.dart';
import 'constants.dart';
import 'page_transitions.dart';
// import 'colors.dart';

/// Holds theme data for [YaruMasterDetailTheme].
@immutable
class MasterDetailThemeData extends ThemeExtension<MasterDetailThemeData>
    with Diagnosticable {
  const MasterDetailThemeData({
    this.breakpoint,
    this.tileSpacing,
    this.listPadding,
    this.portraitTransitions,
    this.landscapeTransitions,
    this.includeSeparator,
    this.sideBarColor,
  });

  factory MasterDetailThemeData.fallback(BuildContext context) {
    final materialTheme = MacosTheme.of(context);
    final light = materialTheme.brightness == Brightness.light;

    return MasterDetailThemeData(
      breakpoint: kMasterDetailBreakpoint,
      tileSpacing: 6,
      listPadding: const EdgeInsets.symmetric(vertical: 8),
      portraitTransitions: MasterDetailPageTransitionsTheme.horizontal,
      landscapeTransitions: MasterDetailPageTransitionsTheme.vertical,
      includeSeparator: true,
      sideBarColor: light
          ? MacosThemeData.light(accentColor: materialTheme.accentColor)
              .canvasColor /*colorScheme.background.scale(lightness: -0.029)*/
          : MacosThemeData.dark(accentColor: materialTheme.accentColor)
              .canvasColor /*materialTheme.colorScheme.surface*/,
    );
  }

  /// The breakpoint at which `YaruMasterDetailPage` switches between portrait
  /// and landscape layouts.
  final double? breakpoint;

  /// The spacing between tiles in the master list.
  final double? tileSpacing;

  /// The padding around the master list.
  final EdgeInsetsGeometry? listPadding;

  /// The page transitions to use when in portrait mode.
  final PageTransitionsTheme? portraitTransitions;

  /// The page transitions to use when in landscape mode.
  final PageTransitionsTheme? landscapeTransitions;

  /// Controls whether a separator should be included between the content and the sidebar.
  /// Defaults to `true`
  final bool? includeSeparator;

  /// The color of the sidebar. Defaults to `Theme.of(context).colorScheme.surface`,
  /// where `Theme` is the material theme.
  final Color? sideBarColor;

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  @override
  MasterDetailThemeData copyWith({
    double? breakpoint,
    double? tileSpacing,
    EdgeInsetsGeometry? listPadding,
    PageTransitionsTheme? portraitTransitions,
    PageTransitionsTheme? landscapeTransitions,
    bool? includeSeparator,
    Color? sideBarColor,
  }) {
    return MasterDetailThemeData(
      breakpoint: breakpoint ?? this.breakpoint,
      tileSpacing: tileSpacing ?? this.tileSpacing,
      listPadding: listPadding ?? this.listPadding,
      portraitTransitions: portraitTransitions ?? this.portraitTransitions,
      landscapeTransitions: landscapeTransitions ?? this.landscapeTransitions,
      includeSeparator: includeSeparator ?? this.includeSeparator,
      sideBarColor: sideBarColor ?? this.sideBarColor,
    );
  }

  @override
  ThemeExtension<MasterDetailThemeData> lerp(
    ThemeExtension<MasterDetailThemeData>? other,
    double t,
  ) {
    final o = other as MasterDetailThemeData?;
    return MasterDetailThemeData(
      breakpoint: lerpDouble(breakpoint, o?.breakpoint, t),
      tileSpacing: lerpDouble(tileSpacing, o?.tileSpacing, t),
      listPadding: EdgeInsetsGeometry.lerp(listPadding, o?.listPadding, t),
      portraitTransitions:
          t < 0.5 ? portraitTransitions : o?.portraitTransitions,
      landscapeTransitions:
          t < 0.5 ? landscapeTransitions : o?.landscapeTransitions,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('breakpoint', breakpoint));
    properties.add(DoubleProperty('tileSpacing', tileSpacing));
    properties.add(DiagnosticsProperty('listPadding', listPadding));
    properties
        .add(DiagnosticsProperty('portraitTransitions', portraitTransitions));
    properties
        .add(DiagnosticsProperty('landscapeTransitions', landscapeTransitions));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MasterDetailThemeData &&
        other.breakpoint == breakpoint &&
        other.tileSpacing == tileSpacing &&
        other.listPadding == listPadding &&
        other.portraitTransitions == portraitTransitions &&
        other.landscapeTransitions == landscapeTransitions;
  }

  @override
  int get hashCode {
    return Object.hash(
      breakpoint,
      tileSpacing,
      listPadding,
      portraitTransitions,
      landscapeTransitions,
    );
  }
}

/// Applies theme to a descendant [YaruMasterDetailPage].
class MasterDetailTheme extends InheritedTheme {
  const MasterDetailTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final MasterDetailThemeData data;

  static MasterDetailThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<MasterDetailTheme>();
    return theme?.data ??
        /*MacosTheme.of(context).extension<MasterDetailThemeData>() ??*/
        MasterDetailThemeData.fallback(context);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MasterDetailTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MasterDetailTheme oldWidget) {
    return data != oldWidget.data;
  }
}
