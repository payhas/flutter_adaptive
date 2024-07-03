import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';
import 'master_detail/portrait_layout.dart';

class MaterialPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    return MaterialPage(component: component);
  }
}

class MaterialPage extends StatefulWidget {
  const MaterialPage({super.key, required this.component});

  final AdaptivePage component;

  @override
  MaterialPageState createState() => MaterialPageState();
}

class MaterialPageState extends State<MaterialPage> {
  @override
  Widget build(BuildContext context) {
    BottomWithDrawerNavigationMenuScope? bottomWithDrawerNavigationMenuScope =
        BottomWithDrawerNavigationMenuScope.maybeOf(context);

    ModalNavigationDrawerMenuScope? modalNavigationDrawerMenuScope =
        ModalNavigationDrawerMenuScope.maybeOf(context);

    MaterialPortraitDetailBuilderPage? materialDetailPage =
        context.findAncestorWidgetOfExactType<MaterialPortraitDetailBuilderPage>();

    Widget? drawer() {
      if (materialDetailPage == null) {
        return bottomWithDrawerNavigationMenuScope?.groupedDrawer ??
            modalNavigationDrawerMenuScope?.groupedDrawer;
      }

      return null;
    }

    return Scaffold(
      body: widget.component.child,
      appBar: widget.component.appBar?.build(context) as AppBar?,
      drawer: drawer(),
      bottomNavigationBar: widget.component.bottomBar,
    );
  }
}
