import 'package:macos_ui/macos_ui.dart';
import 'package:flutter/cupertino.dart';
import '../../../../layouts/adaptive_master_detail.dart';

const _kDetailPageHeroTag = '<DetailPage hero tag>';

/// Provides the recommended layout for [YaruMasterDetailPage.pageBuilder].
///
/// This widget is similar to [Scaffold] with the exception that it wraps the
/// [appBar] in a [Hero] to keep it in place at the top during page transitions.
class MacosUIDetailPage extends StatelessWidget {
  const MacosUIDetailPage({
    super.key,
    this.appBarActions,
    this.appBarTitle,
    this.body,
    // this.floatingActionButton,
    // this.floatingActionButtonLocation,
    // this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.heroTag = _kDetailPageHeroTag,
  });

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.appBar].
  final /*ToolBar?*/ List<MasterDetailAppBarActionsItem>? appBarActions;

  final Widget? appBarTitle;

  /// See [Scaffold.child].
  final Widget? body;

  // /// See [Scaffold.floatingActionButton].
  // final Widget? floatingActionButton;

  // /// See [Scaffold.floatingActionButtonLocation].
  // final FloatingActionButtonLocation? floatingActionButtonLocation;

  // /// See [Scaffold.floatingActionButtonAnimator].
  // final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.persistentFooterAlignment].
  final AlignmentDirectional persistentFooterAlignment;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomNavigationBar].
  final Widget? bottomNavigationBar;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// The tag to use for the [Hero] wrapping the [appBar].
  ///
  /// By default, a unique tag is used to ensure that the [appBar] stays in
  /// place during page transitions. If set to `null`, no [Hero] will be used.
  final Object? heroTag;

  ToolBar? _buildAppBar(BuildContext context) {
    final appBar = appBarActions == null
        ? null
        : ToolBar(
            title: appBarTitle,
            decoration: BoxDecoration(
              color: MacosTheme.of(context).canvasColor,
            ),
            dividerColor: MacosTheme.of(context).dividerColor,
            actions: [
              for (final item in appBarActions!)
                ToolBarIconButton(
                  label: item.title,
                  icon: item.icon ?? const MacosIcon(CupertinoIcons.app),
                  showLabel: false,
                  onPressed: item.onPressed,
                ),
            ],
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
    List<Widget> widgets = [];
    widgets.add(
      ContentArea(
        builder: (context, scrollController) {
          return Container(
            color: MacosTheme.of(context).canvasColor,
            child: body ??
                const Placeholder(
                  child: Text("Details"),
                ),
          );
        },
      ),
    );
    return MacosScaffold(
      toolBar: _buildAppBar(context),
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
      children: widgets,
    );
  }
}
