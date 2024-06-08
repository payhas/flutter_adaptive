import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'constants.dart';
// import 'extensions.dart';

const double _kScrollbarThickness = 8.0;
const double _kScrollbarMargin = 2.0;
const Duration _kSelectedTileAnimationDuration = Duration(milliseconds: 250);

/// Provides the recommended layout for [YaruMasterDetailPage.tileBuilder].
///
/// This widget is structurally similar to [ListTile].
class CupertinoMasterTile extends StatelessWidget {
  const CupertinoMasterTile({
    super.key,
    this.selected,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  /// See [ListTile.selected].
  final bool? selected;

  /// See [ListTile.leading].
  final Widget? leading;

  /// See [ListTile.title].
  final Widget? title;

  /// See [ListTile.subtitle].
  final Widget? subtitle;

  /// See [ListTile.trailing].
  final Widget? trailing;

  /// An optional [VoidCallback] forwarded to the internal [ListTile]
  /// If not provided [YaruMasterTileScope] `onTap` will be called.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final scope = CupertinoMasterTileScope.maybeOf(context);

    final isSelected = selected ?? scope?.selected ?? false;
    final scrollbarThicknessWithTrack =
        _calcScrollbarThicknessWithTrack(context);

    final colorScheme = ColorScheme.fromSeed(
        seedColor: theme.primaryColor,
        brightness: theme.brightness ?? Brightness.light);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scrollbarThicknessWithTrack),
      child: AnimatedContainer(
        duration: _kSelectedTileAnimationDuration,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(kButtonRadius)),
          color: isSelected
              ? /*theme.*/ colorScheme.onSurface.withOpacity(0.07)
              : null,
        ),
        child: CupertinoListTile(
          // selectedColor: theme.colorScheme.onSurface,
          // iconColor: theme.colorScheme.onSurface.withOpacity(0.8),
          // minVerticalPadding: 6,
          // visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          // shape: RoundedRectangleBorder(
          //   borderRadius:
          //       const BorderRadius.all(Radius.circular(kButtonRadius)),
          //   side: theme.colorScheme.isHighContrast && isSelected
          //       ? BorderSide(
          //           color: theme.colorScheme.outlineVariant,
          //           strokeAlign: BorderSide.strokeAlignOutside,
          //         )
          //       : BorderSide.none,
          // ),
          leading: leading,
          title: _titleStyle(context, title) ?? const Text(""),
          subtitle: _subTitleStyle(context, subtitle),
          trailing: trailing,
          // selected: isSelected,
          onTap: () {
            if (onTap != null) {
              onTap!.call();
            } else {
              scope?.onTap();
            }
          },
        ),
      ),
    );
  }

  Widget? _titleStyle(BuildContext context, Widget? child) {
    if (child == null) {
      return child;
    }

    final colorScheme = ColorScheme.fromSeed(
        seedColor: CupertinoTheme.of(context).primaryColor,
        brightness: CupertinoTheme.of(context).brightness ?? Brightness.light);

    return DefaultTextStyle.merge(
      child: child,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: /*CupertinoTheme.of(context).*/ colorScheme.onSurface),
    );
  }

  Widget? _subTitleStyle(BuildContext context, Widget? child) {
    if (child == null) {
      return child;
    }

    return DefaultTextStyle.merge(
      child: child,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: CupertinoTheme.of(context).textTheme.textStyle.color),
    );
  }

  double _calcScrollbarThicknessWithTrack(final BuildContext context) {
    // final scrollbarTheme = CupertinoTheme.of(context) /*.scrollbarTheme*/;

    final doubleMarginWidth = /*scrollbarTheme.crossAxisMargin != null
        ? scrollbarTheme.crossAxisMargin! * 2
        :*/
        _kScrollbarMargin * 2;

    final scrollBarThumbThikness =
        /*scrollbarTheme.thickness?.resolve({WidgetState.hovered}) ??*/
        _kScrollbarThickness;

    return doubleMarginWidth + scrollBarThumbThikness;
  }
}

class CupertinoMasterTileScope extends InheritedWidget {
  const CupertinoMasterTileScope({
    super.key,
    required super.child,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  static CupertinoMasterTileScope of(BuildContext context) {
    return maybeOf(context)!;
  }

  static CupertinoMasterTileScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CupertinoMasterTileScope>();
  }

  @override
  bool updateShouldNotify(CupertinoMasterTileScope oldWidget) {
    return selected != oldWidget.selected || index != oldWidget.index;
  }
}
