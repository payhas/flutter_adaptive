import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart' hide CupertinoIcons, CupertinoTheme;

class CupertinoPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return CupertinoPage(adaptivePage: component);
  }
}

class CupertinoPage extends StatefulWidget {
  const CupertinoPage({super.key, required this.adaptivePage});

  final AdaptivePage adaptivePage;

  @override
  CupertinoPageState createState() => CupertinoPageState();
}

class CupertinoPageState extends State<CupertinoPage> {
  final _bottomBarKey = GlobalKey();
  double _bottomBarHeight = 0.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_bottomBarKey.currentContext != null) {
        RenderBox? renderBox =
            _bottomBarKey.currentContext?.findRenderObject() as RenderBox?;
        setState(() {
          _bottomBarHeight = renderBox?.size.height ?? 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomPosition = 0.0;

    CupertinoTabScaffold? cupertinoTabScaffold =
        context.findAncestorWidgetOfExactType<CupertinoTabScaffold>();

    if (cupertinoTabScaffold != null) {
      bottomPosition = cupertinoTabScaffold.tabBar.height;
    }

    return CupertinoPageScaffold(
      navigationBar:
          widget.adaptivePage.appBar?.build(context) as CupertinoNavigationBar?,
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: widget.adaptivePage.bottomBar != null
                  ? _bottomBarHeight
                  : 0.0),
          child: widget.adaptivePage.child,
        ),
        if (widget.adaptivePage.bottomBar != null)
          Positioned(
              bottom: bottomPosition,
              left: 0.0,
              right: 0.0,
              child: Container(
                  key: _bottomBarKey, child: widget.adaptivePage.bottomBar!))
      ]),
    );
  }
}
