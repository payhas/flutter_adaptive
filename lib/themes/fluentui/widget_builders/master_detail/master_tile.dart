import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart' show ColorScheme;
import 'constants.dart';
// import 'extensions.dart';

const double _kScrollbarThickness = 8.0;
const double _kScrollbarMargin = 2.0;
const Duration _kSelectedTileAnimationDuration = Duration(milliseconds: 250);

/// Provides the recommended layout for [YaruMasterDetailPage.tileBuilder].
///
/// This widget is structurally similar to [ListTile].
class FluentUIMasterTile extends StatelessWidget {
  const FluentUIMasterTile({
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
    final theme = FluentTheme.of(context);
    final scope = FluentUIMasterTileScope.maybeOf(context);

    final isSelected = selected ?? scope?.selected ?? false;
    final scrollbarThicknessWithTrack =
        _calcScrollbarThicknessWithTrack(context);

    // final colorScheme = ColorScheme.fromSeed(seedColor: theme.activeColor);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scrollbarThicknessWithTrack),
      child: AnimatedContainer(
        duration: _kSelectedTileAnimationDuration,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(kButtonRadius)),
          color: isSelected
              ? theme
                  .acrylicBackgroundColor /*colorScheme.onSurface.withOpacity(0.07)*/
              : null,
        ),
        child: ListTile.selectable(
          // selectedColor: theme.colorScheme.onSurface,
          // iconColor: theme.colorScheme.onSurface.withOpacity(0.8),
          // minVerticalPadding: 6,
          // visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kButtonRadius)),
            // side: /*theme.*/ /*colorScheme.isHighContrast &&*/ isSelected
            //     ? BorderSide(
            //         color: theme
            //             .acrylicBackgroundColor /*colorScheme.outlineVariant*/,
            //         strokeAlign: BorderSide.strokeAlignOutside,
            //       )
            //     : BorderSide.none,
          ),
          leading: leading,
          title: _titleStyle(context, title),
          subtitle: _subTitleStyle(context, subtitle),
          trailing: trailing,
          selected: isSelected,
          onPressed: () {
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

    // final colorScheme =
    //     ColorScheme.fromSeed(seedColor: FluentTheme.of(context).activeColor);

    return DefaultTextStyle.merge(
      child: child,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: FluentTheme.of(context).typography.body /*colorScheme.onSurface*/,
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
      // style: TextStyle(color: FluentTheme.of(context).textTheme.bodySmall!.color),
      style: FluentTheme.of(context).typography.body,
    );
  }

  double _calcScrollbarThicknessWithTrack(final BuildContext context) {
    final scrollbarTheme = FluentTheme.of(context).scrollbarTheme;

    final doubleMarginWidth = scrollbarTheme.crossAxisMargin != null
        ? scrollbarTheme.crossAxisMargin! * 2
        : _kScrollbarMargin * 2;

    final scrollBarThumbThikness = scrollbarTheme
            .hoveringThickness /*thickness?.resolve({WidgetState.hovered})*/ ??
        _kScrollbarThickness;

    return doubleMarginWidth + scrollBarThumbThikness;
  }
}

class FluentUIMasterTileScope extends InheritedWidget {
  const FluentUIMasterTileScope({
    super.key,
    required super.child,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  static FluentUIMasterTileScope of(BuildContext context) {
    return maybeOf(context)!;
  }

  static FluentUIMasterTileScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FluentUIMasterTileScope>();
  }

  @override
  bool updateShouldNotify(FluentUIMasterTileScope oldWidget) {
    return selected != oldWidget.selected || index != oldWidget.index;
  }
}
