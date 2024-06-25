import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialPageBuilder extends AdaptiveWidgetBuilder<AdaptivePage> {
  @override
  Widget build(BuildContext context, AdaptivePage component) {
    BottomWithDrawerNavigationMenuScope? bottomWithDrawerNavigationMenuScope =
        BottomWithDrawerNavigationMenuScope.maybeOf(context);

    ModalNavigationDrawerMenuScope? modalNavigationDrawerMenuScope =
        ModalNavigationDrawerMenuScope.maybeOf(context);

    return Scaffold(
      body: component.body,
      appBar: component.appBar?.build(context) as AppBar?,
      drawer: bottomWithDrawerNavigationMenuScope?.groupedDrawer ??
          modalNavigationDrawerMenuScope?.groupedDrawer,
      bottomNavigationBar: component.bottomBar,
    );
  }
}
