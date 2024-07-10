import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/layouts/adaptive_master_detail.dart';
import 'package:flutter/material.dart' show BackButton, Theme;

import 'constants.dart';

const _kDetailPageHeroTag = '<DetailPage hero tag>';

/// Provides the recommended layout for [YaruMasterDetailPage.pageBuilder].
///
/// This widget is similar to [Scaffold] with the exception that it wraps the
/// [appBar] in a [Hero] to keep it in place at the top during page transitions.
class FluentUIDetailPage extends StatelessWidget {
  const FluentUIDetailPage({
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
  final /*PreferredSize*/ /*Widget?*/ List<MasterDetailAppBarActionsItem>?
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

  /*PreferredSize*/ Widget? _buildAppBar(BuildContext context) {
    Widget? wdgt;
    if (Navigator.canPop(context)) {
      wdgt = const BackButton();
    }
    final appBar = appBarActions == null
        ? null
        : PageHeader(
            title: appBarTitle,
            leading: wdgt,
            commandBar: CommandBar(
              isCompact: true,
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                for (final item in appBarActions!)
                  CommandBarButton(
                    icon: item.icon,
                    label: Text(item.title),
                    onPressed: item.onPressed,
                  )
              ],
            ),
          );

    if (appBar == null ||
        heroTag == null ||
        context.findAncestorWidgetOfExactType<Hero>() != null) {
      return appBar;
    }

    return /*PreferredSize(
      preferredSize: appBar!.preferredSize,
      child:*/
        Hero(
      tag: heroTag!,
      child: appBar,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        pageTransitionsTheme: kDetailPageTransitionsTheme,
      ),
      child: ScaffoldPage(
        header: _buildAppBar(context),
        content: body ??
            const Placeholder(
              child: FlutterLogo(),
            ),
        bottomBar: bottomNavigationBar,
      ),
    );
  }
}
