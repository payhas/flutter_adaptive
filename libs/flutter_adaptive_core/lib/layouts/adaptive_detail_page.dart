import 'package:flutter/widgets.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class AdaptiveDetailPage extends AdaptiveWidget {
  const AdaptiveDetailPage({
    super.key,
    this.appBarActions,
    this.appBarTitle,
    this.body,
    this.backgroundColor,
  });

  /// See [Scaffold.appBar].
  final List<MasterDetailAppBarActionsItem>? appBarActions;

  final Widget? appBarTitle;

  /// See [Scaffold.child].
  final Widget? body;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;
}
