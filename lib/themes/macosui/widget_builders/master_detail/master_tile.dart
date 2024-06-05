// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'constants.dart';
// import 'extensions.dart';

const double _kScrollbarThickness = 8.0;
const double _kScrollbarMargin = 2.0;
const Duration _kSelectedTileAnimationDuration = Duration(milliseconds: 250);

/// Provides the recommended layout for [YaruMasterDetailPage.tileBuilder].
///
/// This widget is structurally similar to [ListTile].
class MasterTile extends StatelessWidget {
  const MasterTile({
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
    final theme = MacosTheme.of(context);
    final scope = MasterTileScope.maybeOf(context);

    final isSelected = selected ?? scope?.selected ?? false;
    final scrollbarThicknessWithTrack =
        _calcScrollbarThicknessWithTrack(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scrollbarThicknessWithTrack),
      child: AnimatedContainer(
        duration: _kSelectedTileAnimationDuration,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(kButtonRadius)),
          color: isSelected
              ? theme.canvasColor. /*colorScheme.onSurface.*/ withOpacity(0.07)
              : null,
        ),
        child: MacosListTile(
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
          // trailing: trailing,
          // selected: isSelected,
          /*onTap*/ onClick: () {
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

    return DefaultTextStyle.merge(
      child: child,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: MacosTheme.of(context).canvasColor /*.colorScheme.onSurface*/),
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
          color: MacosTheme.of(context)
              .typography
              .body
              .color /*textTheme.bodySmall!.color*/),
    );
  }

  double _calcScrollbarThicknessWithTrack(final BuildContext context) {
    final scrollbarTheme = MacosTheme.of(context).scrollbarTheme;

    final doubleMarginWidth = /*scrollbarTheme.crossAxisMargin != null
        ? scrollbarTheme.crossAxisMargin! * 2
        :*/
        _kScrollbarMargin * 2;

    final scrollBarThumbThikness =
        scrollbarTheme.thickness /*?.resolve({MaterialState.hovered})*/ ??
            _kScrollbarThickness;

    return doubleMarginWidth + scrollBarThumbThikness;
  }
}

class MasterTileScope extends InheritedWidget {
  const MasterTileScope({
    super.key,
    required super.child,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;

  static MasterTileScope of(BuildContext context) {
    return maybeOf(context)!;
  }

  static MasterTileScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MasterTileScope>();
  }

  @override
  bool updateShouldNotify(MasterTileScope oldWidget) {
    return selected != oldWidget.selected || index != oldWidget.index;
  }
}
