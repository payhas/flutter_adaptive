import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class FluentUINavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return FluentNavigation(groupDestinations: component.groupDestinations);
  }
}

class FluentNavigation extends StatefulWidget {
  const FluentNavigation({super.key, required this.groupDestinations});

  final List<AdaptiveGroupDestination> groupDestinations;

  @override
  FluentNavigationState createState() => FluentNavigationState();
}

class FluentNavigationState extends State<FluentNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var destinations =
        widget.groupDestinations.expand((group) => group.destinations).toList();

    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text("Adaptive Navigation Example"),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: _onItemTapped,
        displayMode: PaneDisplayMode.auto,
        items: [
          for (int i = 0; i < destinations.length; i++) ...[
            PaneItem(
              icon: destinations[i].icon,
              title: Text(destinations[i].label),
              body: destinations[i].page,
            )
          ]
        ],
      ),
    );
  }
}
