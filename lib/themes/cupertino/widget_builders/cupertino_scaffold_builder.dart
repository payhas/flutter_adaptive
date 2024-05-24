import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart'
    hide CupertinoIcons, CupertinoTheme;

class CupertinoScaffoldBuilder extends AdaptiveWidgetBuilder<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context, AdaptiveScaffold component) {
    return CupertinoPageScaffold(
      child: _childBuilder(context, component),
    );
  }

  Widget _childBuilder(BuildContext context, AdaptiveScaffold component) {
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);
    MediaQueryData newMediaQuery = MediaQuery.of(context);

    Widget content = component.body ?? const SizedBox.shrink();

    EdgeInsets contentPadding = EdgeInsets.zero;

    newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
    contentPadding =
        EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);

    final CupertinoNavigationBar? navigationBar =
        component.appBar?.build(context) as CupertinoNavigationBar?;
    final CupertinoTabBar? tabBar =
        component.navigationBar?.build(context) as CupertinoTabBar?;

    if (navigationBar != null) {
      final double topPadding =
          navigationBar.preferredSize.height + existingMediaQuery.padding.top;

      if (navigationBar.shouldFullyObstruct(context)) {
        contentPadding = contentPadding.copyWith(top: topPadding);
        newMediaQuery = newMediaQuery.removePadding(removeTop: true);
      } else {
        newMediaQuery = newMediaQuery.copyWith(
          padding: newMediaQuery.padding.copyWith(
            top: topPadding,
          ),
        );
      }
    }

    if (tabBar != null) {
      final double bottomPadding =
          tabBar.preferredSize.height + existingMediaQuery.padding.bottom;

      if (tabBar.preferredSize.height > existingMediaQuery.viewInsets.bottom) {
        if (tabBar.opaque(context)) {
          contentPadding = contentPadding.copyWith(bottom: bottomPadding);
          newMediaQuery = newMediaQuery.removePadding(removeBottom: true);
        } else {
          newMediaQuery = newMediaQuery.copyWith(
            padding: newMediaQuery.padding.copyWith(
              bottom: bottomPadding,
            ),
          );
        }
      }
    }

    content = MediaQuery(
      data: newMediaQuery,
      child: Padding(
        padding: contentPadding,
        child: content,
      ),
    );

    return Stack(
      children: <Widget>[
        content,
        if (navigationBar != null)
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: MediaQuery.withNoTextScaling(
              child: navigationBar,
            ),
          ),
        if (tabBar != null)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: MediaQuery.withNoTextScaling(
              child: tabBar.copyWith(
                onTap: (int newIndex) {
                  tabBar.onTap?.call(newIndex);
                },
              ),
            ),
          ),
      ],
    );
  }
}
