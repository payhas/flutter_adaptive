import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart'
    hide CupertinoIcons;

const _kDetailPageHeroTag = '<DetailPage hero tag>';

/// Provides the recommended layout for [YaruMasterDetailPage.pageBuilder].
///
/// This widget is similar to [Scaffold] with the exception that it wraps the
/// [appBar] in a [Hero] to keep it in place at the top during page transitions.
class CupertinoDetailPage extends StatelessWidget {
  const CupertinoDetailPage({
    super.key,
    this.appBarActions,
    this.appBarTitle,
    this.body,
    // this.floatingActionButton,
    // this.floatingActionButtonLocation,
    // this.floatingActionButtonAnimator,
    // this.persistentFooterButtons,
    // this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    // this.bottomNavigationBar,
    // this.bottomSheet,
    this.backgroundColor,
    // this.extendBody = false,
    // this.extendBodyBehindAppBar = false,
    this.heroTag = _kDetailPageHeroTag,
  });

  // /// See [Scaffold.extendBody].
  // final bool extendBody;

  // /// See [Scaffold.extendBodyBehindAppBar].
  // final bool extendBodyBehindAppBar;

  /// See [Scaffold.appBar].
  final /*ObstructingPreferredSizeWidget?*/ List<MasterDetailAppBarActionsItem>?
      appBarActions;

  final Widget? appBarTitle;

  /// See [Scaffold.child].
  final Widget? body;

  // /// See [Scaffold.floatingActionButton].
  // final Widget? floatingActionButton;

  // /// See [Scaffold.floatingActionButtonLocation].
  // final FloatingActionButtonLocation? floatingActionButtonLocation;

  // /// See [Scaffold.floatingActionButtonAnimator].
  // final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  // /// See [Scaffold.persistentFooterButtons].
  // final List<Widget>? persistentFooterButtons;

  // /// See [Scaffold.persistentFooterAlignment].
  // final AlignmentDirectional persistentFooterAlignment;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  // /// See [Scaffold.bottomNavigationBar].
  // final Widget? bottomNavigationBar;

  // /// See [Scaffold.bottomSheet].
  // final Widget? bottomSheet;

  /// The tag to use for the [Hero] wrapping the [appBar].
  ///
  /// By default, a unique tag is used to ensure that the [appBar] stays in
  /// place during page transitions. If set to `null`, no [Hero] will be used.
  final Object? heroTag;

  ObstructingPreferredSizeWidget? _buildAppBar(BuildContext context) {
    final appBar = (appBarActions == null)
        ? null
        : CupertinoNavigationBar(
            middle: appBarTitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (final item in appBarActions!)
                  CupertinoButton(
                    // color: CupertinoColors.activeGreen,
                    // alignment: Alignment.topCenter,
                    onPressed: item.onPressed,
                    child: item.icon ?? const Icon(CupertinoIcons.rectangle),
                  ),
              ],
            ),
          );
    if (appBar == null ||
        heroTag == null ||
        context.findAncestorWidgetOfExactType<Hero>() != null) {
      return appBar;
    }

    return appBar; /*PreferredSize(
      preferredSize: appBar!.preferredSize,
      child: Hero(
        tag: heroTag!,
        child: appBar!,
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
          _buildAppBar(context) /*as ObstructingPreferredSizeWidget*/,
      // floatingActionButton: floatingActionButton,
      // floatingActionButtonLocation: floatingActionButtonLocation,
      // floatingActionButtonAnimator: floatingActionButtonAnimator,
      // persistentFooterButtons: persistentFooterButtons,
      // persistentFooterAlignment: persistentFooterAlignment,
      // bottomNavigationBar: bottomNavigationBar,
      // bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      // extendBody: extendBody,
      // extendBodyBehindAppBar: extendBodyBehindAppBar,
      child: body ?? const Placeholder(),
    );
  }
}
