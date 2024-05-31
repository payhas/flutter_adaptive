import 'package:flutter/material.dart';
import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/components/adaptive_navigation.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosUINavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return MacosNavigation(destinations: component.destinations);
  }
}

class MacosNavigation extends StatefulWidget {
  const MacosNavigation({super.key, required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  MacosNavigationState createState() => MacosNavigationState();
}

class MacosNavigationState extends State<MacosNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      titleBar: const TitleBar(
        title: Text('Adaptive Navigation Example'),
      ),
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _selectedIndex,
            onChanged: _onItemTapped,
            items: widget.destinations.map((dest) {
              return SidebarItem(
                leading: dest.icon,
                label: Text(dest.label),
              );
            }).toList(),
          );
        },
      ),
      child: widget.destinations[_selectedIndex].page,
    );
  }
}
