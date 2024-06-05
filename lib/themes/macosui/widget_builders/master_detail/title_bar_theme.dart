import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeExtension;
import 'package:flutter/widgets.dart';
// import 'package:macos_ui/macos_ui.dart';

/// The title bar style.
enum TitleBarStyle {
  /// The title bar is hidden.
  hidden,

  /// The title bar is shown without window controls.
  undecorated,

  /// The title bar is shown as normal.
  normal,
}

@immutable
class TitleBarThemeData extends ThemeExtension<TitleBarThemeData>
    with Diagnosticable {
  const TitleBarThemeData({
    this.elevation = 0,
    this.centerTitle = true,
    this.titleSpacing,
    this.buttonSpacing,
    this.buttonPadding,
    this.foregroundColor,
    this.backgroundColor,
    this.titleTextStyle,
    this.shape,
    this.border,
    this.style,
  });

  final double? elevation;
  final bool? centerTitle;
  final double? titleSpacing;
  final double? buttonSpacing;
  final EdgeInsetsGeometry? buttonPadding;
  final WidgetStateProperty<Color?>? foregroundColor;
  final WidgetStateProperty<Color?>? backgroundColor;
  final TextStyle? titleTextStyle;
  final ShapeBorder? shape;
  final BorderSide? border;
  final TitleBarStyle? style;

  @override
  TitleBarThemeData copyWith({
    double? elevation,
    bool? centerTitle,
    double? titleSpacing,
    double? buttonSpacing,
    EdgeInsetsGeometry? buttonPadding,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? backgroundColor,
    TextStyle? titleTextStyle,
    ShapeBorder? shape,
    BorderSide? border,
    TitleBarStyle? style,
  }) {
    return TitleBarThemeData(
      elevation: elevation ?? this.elevation,
      centerTitle: centerTitle ?? this.centerTitle,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      shape: shape ?? this.shape,
      border: border ?? this.border,
      style: style ?? this.style,
    );
  }

  @override
  ThemeExtension<TitleBarThemeData> lerp(
    ThemeExtension<TitleBarThemeData>? other,
    double t,
  ) {
    final o = other as TitleBarThemeData?;
    return TitleBarThemeData(
      elevation: lerpDouble(elevation, o?.elevation, t),
      centerTitle: t < 0.5 ? centerTitle : o?.centerTitle,
      titleSpacing: lerpDouble(titleSpacing, o?.titleSpacing, t),
      buttonSpacing: lerpDouble(buttonSpacing, o?.buttonSpacing, t),
      buttonPadding:
          EdgeInsetsGeometry.lerp(buttonPadding, o?.buttonPadding, t),
      foregroundColor: WidgetStateProperty.lerp<Color?>(
        foregroundColor,
        o?.foregroundColor,
        t,
        Color.lerp,
      ),
      backgroundColor: WidgetStateProperty.lerp<Color?>(
        backgroundColor,
        o?.backgroundColor,
        t,
        Color.lerp,
      ),
      titleTextStyle: TextStyle.lerp(titleTextStyle, o?.titleTextStyle, t),
      shape: ShapeBorder.lerp(shape, o?.shape, t),
      border: _lerpBorderSide(border, o?.border, t),
      style: t < 0.5 ? style : o?.style,
    );
  }

  // Special case because BorderSide.lerp() doesn't support null arguments.
  static BorderSide? _lerpBorderSide(BorderSide? a, BorderSide? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    if (a == null) {
      return BorderSide.lerp(
        BorderSide(width: 0, color: b!.color.withAlpha(0)),
        b,
        t,
      );
    }
    if (b == null) {
      return BorderSide.lerp(
        BorderSide(width: 0, color: a.color.withAlpha(0)),
        a,
        t,
      );
    }
    return BorderSide.lerp(a, b, t);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DiagnosticsProperty('centerTitle', centerTitle));
    properties.add(DoubleProperty('titleSpacing', titleSpacing));
    properties.add(DoubleProperty('buttonSpacing', buttonSpacing));
    properties.add(DiagnosticsProperty('buttonPadding', buttonPadding));
    properties.add(DiagnosticsProperty('foregroundColor', foregroundColor));
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('titleTextStyle', titleTextStyle));
    properties.add(DiagnosticsProperty('shape', shape));
    properties.add(DiagnosticsProperty('border', border));
    properties.add(DiagnosticsProperty('style', style));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TitleBarThemeData &&
        other.elevation == elevation &&
        other.centerTitle == centerTitle &&
        other.titleSpacing == titleSpacing &&
        other.buttonSpacing == buttonSpacing &&
        other.buttonPadding == buttonPadding &&
        other.foregroundColor == foregroundColor &&
        other.backgroundColor == backgroundColor &&
        other.titleTextStyle == titleTextStyle &&
        other.shape == shape &&
        other.border == border &&
        other.style == style;
  }

  @override
  int get hashCode {
    return Object.hash(
      elevation,
      centerTitle,
      titleSpacing,
      buttonSpacing,
      buttonPadding,
      foregroundColor,
      backgroundColor,
      titleTextStyle,
      shape,
      border,
      style,
    );
  }
}

class TitleBarTheme extends InheritedTheme {
  const TitleBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final TitleBarThemeData data;

  static TitleBarThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TitleBarTheme>();
    return theme?.data ??
        /*MacosTheme.of(context).extension<TitleBarThemeData>() ??*/
        const TitleBarThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TitleBarTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(TitleBarTheme oldWidget) {
    return data != oldWidget.data;
  }
}
