import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:yaru/widgets.dart';

class FluentUINavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return FluentNavigation(
      groupDestinations: component.groupDestinations,
      showOnlyModalNavigationDrawerOnDesktop:
          component.showOnlyModalNavigationDrawerOnDesktop,
      showOnlyNavigationRailOnDesktop:
          component.showOnlyNavigationRailOnDesktop,
    );
  }
}

class FluentNavigation extends StatefulWidget {
  FluentNavigation(
      {super.key,
      required this.groupDestinations,
      required this.showOnlyModalNavigationDrawerOnDesktop,
      required this.showOnlyNavigationRailOnDesktop})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnDrawerSidebar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true',
        ),
        assert(showOnlyModalNavigationDrawerOnDesktop == false ||
            showOnlyNavigationRailOnDesktop == false);

  final List<AdaptiveGroupDestination> groupDestinations;
  final bool showOnlyModalNavigationDrawerOnDesktop;
  final bool showOnlyNavigationRailOnDesktop;

  @override
  FluentNavigationState createState() => FluentNavigationState();
}

class FluentNavigationState extends State<FluentNavigation> {
  int _selectedIndex = 0;

  final FluentBackButtonNotifier fluentBackButtonNotifier =
      FluentBackButtonNotifier();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    window();
  }

  Future<void> window() async {
    await YaruWindowTitleBar.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    var paneDisplayMode = PaneDisplayMode.auto;

    double menuWidth = 50.0;

    if (widget.showOnlyModalNavigationDrawerOnDesktop) {
      paneDisplayMode = PaneDisplayMode.minimal;
      menuWidth = 100.0;
    }

    if (widget.showOnlyNavigationRailOnDesktop) {
      paneDisplayMode = PaneDisplayMode.compact;
    }

    if (paneDisplayMode == PaneDisplayMode.auto &&
        MediaQuery.sizeOf(context).width <= 640) {
      menuWidth = 100.0;
    }

    var drawerGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    var allDestinations =
        drawerGroupDestinations.expand((group) => group.destinations).toList();

    Widget leading() {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      final canPop = parentRoute?.canPop ?? false;

      final localizations = FluentLocalizations.of(context);
      final onPressed = canPop ? () => Navigator.maybePop(context) : null;

      return NavigationPaneTheme(
        data: NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
          unselectedIconColor: ButtonState.resolveWith((states) {
            if (states.isDisabled) {
              return ButtonThemeData.buttonColor(context, states);
            }
            return ButtonThemeData.uncheckedInputColor(
              FluentTheme.of(context),
              states,
            ).basedOnLuminance();
          }),
        )),
        child: Builder(
          builder: (context) => PaneItem(
            icon: const Icon(FluentIcons.back, size: 14.0),
            title: Text(localizations.backButtonTooltip),
            body: const SizedBox.shrink(),
          ).build(
            context,
            false,
            () {
              onPressed?.call();
              fluentBackButtonNotifier.onPressed();
            },
            displayMode: PaneDisplayMode.compact,
          ),
        ),
      );
    }

    return NavigationView(
      appBar: NavigationAppBar(
        leading: leading(),
        title: Text(allDestinations[_selectedIndex].label),
        actions: Row(
          children: [
            SizedBox(width: menuWidth),
            const Expanded(
              child: YaruWindowTitleBar(
                title: SizedBox.shrink(),
                border: BorderSide.none,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: _onItemTapped,
        displayMode: paneDisplayMode,
        items: [
          for (int i = 0; i < allDestinations.length; i++) ...[
            PaneItem(
              icon: allDestinations[i].icon,
              title: Text(allDestinations[i].label),
              body: allDestinations[i].page,
            )
          ]
        ],
      ),
    );
  }
}

class FluentBackButtonNotifier with ChangeNotifier {
  void onPressed() {
    notifyListeners();
  }
}
