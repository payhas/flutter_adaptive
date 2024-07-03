import 'package:flutter_adaptive/base/adaptive_widget_builder.dart';
import 'package:flutter_adaptive/components/adaptive_navigation.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:macos_ui/src/library.dart';

const Duration _kExpand = Duration(milliseconds: 200);
const ShapeBorder _defaultShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

class MacosUINavigationBuilder
    extends AdaptiveWidgetBuilder<AdaptiveNavigation> {
  @override
  Widget build(BuildContext context, AdaptiveNavigation component) {
    return MacosNavigation(groupDestinations: component.groupDestinations);
  }
}

class MacosNavigation extends StatefulWidget {
  MacosNavigation({super.key, required this.groupDestinations})
      : assert(
          groupDestinations
                  .expand((group) => group.destinations)
                  .where(
                      (destination) => destination.showOnDrawerSidebar == true)
                  .length >=
              2,
          'There must be at least 2 AdaptiveDestinations with showOnDrawerSidebar = true',
        );

  final List<AdaptiveGroupDestination> groupDestinations;

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
    var sidebarGroupDestinations =
        drawerSidebarGroupDestinations(widget.groupDestinations);

    var allDestinations =
        sidebarGroupDestinations.expand((group) => group.destinations).toList();

    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return GroupSidebarItems(
            scrollController: scrollController,
            groupDestinations: sidebarGroupDestinations,
            itemSize: SidebarItemSize.large,
            currentIndex: _selectedIndex,
            onChanged: _onItemTapped,
            items: allDestinations.map((dest) {
              int index = allDestinations.indexOf(dest);
              return SidebarItem(
                leading: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == index
                          ? CupertinoColors.white
                          : CupertinoColors.systemBlue,
                      BlendMode.srcIn),
                  child: dest.icon,
                ),
                label: Text(dest.label),
              );
            }).toList(),
          );
        },
      ),
      child: allDestinations[_selectedIndex].page,
    );
  }
}

class GroupSidebarItems extends SidebarItems {
  const GroupSidebarItems(
      {super.key,
      required this.groupDestinations,
      required super.items,
      required super.currentIndex,
      required super.onChanged,
      super.itemSize,
      super.scrollController});

  final List<AdaptiveGroupDestination> groupDestinations;

  Color _getColor(BuildContext context) {
    final isMainWindow = WindowMainStateListener.instance.isMainWindow;

    return _ColorProvider.getSelectedColor(
      accentColor: _getAccentColor(context),
      isDarkModeEnabled: MacosTheme.of(context).brightness.isDark,
      isWindowMain: isMainWindow,
    );
  }

  AccentColor _getAccentColor(BuildContext context) =>
      MacosTheme.of(context).accentColor ?? AccentColor.blue;

  List<SidebarItem> get _allItems {
    List<SidebarItem> result = [];
    for (var element in items) {
      if (element.disclosureItems != null) {
        result.addAll(element.disclosureItems!);
      } else {
        result.add(element);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    assert(debugCheckHasMacosTheme(context));
    assert(currentIndex < _allItems.length);
    final theme = MacosTheme.of(context);
    return MacosIconTheme.merge(
      data: const MacosIconThemeData(size: 20),
      child: StreamBuilder(
        stream: AccentColorListener.instance.onChanged,
        builder: (context, _) {
          return StreamBuilder<bool>(
            stream: WindowMainStateListener.instance.onChanged,
            builder: (context, _) {
              return _SidebarItemsConfiguration(
                selectedColor: selectedColor ?? _getColor(context),
                unselectedColor: unselectedColor ?? MacosColors.transparent,
                shape: shape ?? _defaultShape,
                itemSize: itemSize,
                child: ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding:
                        EdgeInsets.all(10.0 - theme.visualDensity.horizontal),
                    children: _buildGroupedSidebarItems(context)),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedSidebarItems(BuildContext context) {
    int startItemIndex = 0;

    return [
      for (int i = 0;
          i < groupDestinations.length;
          startItemIndex += groupDestinations[i].destinations.length, i++) ...[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 5.0),
          child: Text(groupDestinations[i].name,
              style: MacosTheme.of(context).typography.headline),
        ),
        for (int j = startItemIndex;
            j < startItemIndex + groupDestinations[i].destinations.length;
            j++) ...[
          Builder(builder: (context) {
            final item = items[j];
            if (item.disclosureItems != null) {
              return MouseRegion(
                cursor: cursor!,
                child: _DisclosureSidebarItem(
                  item: item,
                  selectedItem: _allItems[currentIndex],
                  onChanged: (item) {
                    onChanged(_allItems.indexOf(item));
                  },
                ),
              );
            }
            return MouseRegion(
              cursor: cursor!,
              child: _SidebarItem(
                item: item,
                selected: _allItems[currentIndex] == item,
                onClick: () => onChanged(_allItems.indexOf(item)),
              ),
            );
          })
        ],
      ],
    ];
  }
}

class _DisclosureSidebarItem extends StatefulWidget {
  // ignore: use_super_parameters
  _DisclosureSidebarItem({
    Key? key,
    required this.item,
    this.selectedItem,
    this.onChanged,
  })  : assert(item.disclosureItems != null),
        super(key: key);

  final SidebarItem item;

  final SidebarItem? selectedItem;

  final ValueChanged<SidebarItem>? onChanged;

  @override
  __DisclosureSidebarItemState createState() => __DisclosureSidebarItemState();
}

class __DisclosureSidebarItemState extends State<_DisclosureSidebarItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.25);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  bool get hasLeading => widget.item.leading != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final theme = MacosTheme.of(context);
    final double spacing = 10.0 + theme.visualDensity.horizontal;

    final itemSize = _SidebarItemsConfiguration.of(context).itemSize;
    TextStyle? labelStyle;
    switch (itemSize) {
      case SidebarItemSize.small:
        labelStyle = theme.typography.subheadline;
        break;
      case SidebarItemSize.medium:
        labelStyle = theme.typography.body;
        break;
      case SidebarItemSize.large:
        labelStyle = theme.typography.title3;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: _SidebarItem(
            item: SidebarItem(
              label: widget.item.label,
              leading: Row(
                children: [
                  RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12.0,
                      color: theme.brightness == Brightness.light
                          ? MacosColors.black
                          : MacosColors.white,
                    ),
                  ),
                  if (hasLeading)
                    Padding(
                      padding: EdgeInsets.only(left: spacing),
                      child: MacosIconTheme.merge(
                        data: MacosIconThemeData(size: itemSize.iconSize),
                        child: widget.item.leading!,
                      ),
                    ),
                ],
              ),
              unselectedColor: MacosColors.transparent,
              focusNode: widget.item.focusNode,
              semanticLabel: widget.item.semanticLabel,
              shape: widget.item.shape,
              trailing: widget.item.trailing,
            ),
            onClick: _handleTap,
            selected: false,
          ),
        ),
        ClipRect(
          child: DefaultTextStyle(
            style: labelStyle,
            child: Align(
              alignment: Alignment.centerLeft,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMacosTheme(context));
    final theme = MacosTheme.of(context);

    final bool closed = !_isExpanded && _controller.isDismissed;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.item.disclosureItems!.map((item) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24.0 + theme.visualDensity.horizontal,
              ),
              child: SizedBox(
                width: double.infinity,
                child: _SidebarItem(
                  item: item,
                  onClick: () => widget.onChanged?.call(item),
                  selected: widget.selectedItem == item,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : result,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  // ignore: use_super_parameters
  const _SidebarItem({
    Key? key,
    required this.item,
    required this.onClick,
    required this.selected,
  }) : super(key: key);

  final SidebarItem item;

  final bool selected;

  final VoidCallback? onClick;

  void _handleActionTap() => onClick?.call();

  Map<Type, Action<Intent>> get _actionMap => <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (ActivateIntent intent) => _handleActionTap(),
        ),
        ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
          onInvoke: (ButtonActivateIntent intent) => _handleActionTap(),
        ),
      };

  bool get hasLeading => item.leading != null;

  bool get hasTrailing => item.trailing != null;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMacosTheme(context));
    final theme = MacosTheme.of(context);

    final selectedColor = MacosDynamicColor.resolve(
      item.selectedColor ??
          _SidebarItemsConfiguration.of(context).selectedColor,
      context,
    );
    final unselectedColor = MacosDynamicColor.resolve(
      item.unselectedColor ??
          _SidebarItemsConfiguration.of(context).unselectedColor,
      context,
    );

    final double spacing = 10.0 + theme.visualDensity.horizontal;
    final itemSize = _SidebarItemsConfiguration.of(context).itemSize;
    TextStyle? labelStyle;
    switch (itemSize) {
      case SidebarItemSize.small:
        labelStyle = theme.typography.subheadline;
        break;
      case SidebarItemSize.medium:
        labelStyle = theme.typography.body;
        break;
      case SidebarItemSize.large:
        labelStyle = theme.typography.title3;
        break;
    }

    return Semantics(
      label: item.semanticLabel,
      button: true,
      focusable: true,
      focused: item.focusNode?.hasFocus,
      enabled: onClick != null,
      selected: selected,
      child: GestureDetector(
        onTap: onClick,
        child: FocusableActionDetector(
          focusNode: item.focusNode,
          descendantsAreFocusable: false,
          enabled: onClick != null,
          //mouseCursor: SystemMouseCursors.basic,
          actions: _actionMap,
          child: Container(
            width: 134.0 + theme.visualDensity.horizontal,
            height: itemSize.height + theme.visualDensity.vertical,
            decoration: ShapeDecoration(
              color: selected ? selectedColor : unselectedColor,
              shape: item.shape ?? _SidebarItemsConfiguration.of(context).shape,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 7 + theme.visualDensity.horizontal,
              horizontal: spacing,
            ),
            child: Row(
              children: [
                if (hasLeading)
                  Padding(
                    padding: EdgeInsets.only(right: spacing),
                    child: MacosIconTheme.merge(
                      data: MacosIconThemeData(
                        color:
                            selected ? MacosColors.white : theme.primaryColor,
                        size: itemSize.iconSize,
                      ),
                      child: item.leading!,
                    ),
                  ),
                DefaultTextStyle(
                  style: labelStyle.copyWith(
                    color: selected ? textLuminance(selectedColor) : null,
                  ),
                  child: item.label,
                ),
                if (hasTrailing) ...[
                  const Spacer(),
                  DefaultTextStyle(
                    style: labelStyle.copyWith(
                      color: selected ? textLuminance(selectedColor) : null,
                    ),
                    child: item.trailing!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarItemsConfiguration extends InheritedWidget {
  // ignore: use_super_parameters
  const _SidebarItemsConfiguration({
    Key? key,
    required super.child,
    this.selectedColor = MacosColors.transparent,
    this.unselectedColor = MacosColors.transparent,
    this.shape = _defaultShape,
    this.itemSize = SidebarItemSize.medium,
  }) : super(key: key);

  final Color selectedColor;
  final Color unselectedColor;
  final ShapeBorder shape;
  final SidebarItemSize itemSize;

  static _SidebarItemsConfiguration of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SidebarItemsConfiguration>()!;
  }

  @override
  bool updateShouldNotify(_SidebarItemsConfiguration oldWidget) {
    return true;
  }
}

class _ColorProvider {
  static Color getSelectedColor({
    required AccentColor accentColor,
    required bool isDarkModeEnabled,
    required bool isWindowMain,
  }) {
    if (isDarkModeEnabled) {
      if (!isWindowMain) {
        return const MacosColor.fromRGBO(76, 78, 65, 1.0);
      }

      switch (accentColor) {
        case AccentColor.blue:
          return const MacosColor.fromRGBO(22, 105, 229, 0.749);

        case AccentColor.purple:
          return const MacosColor.fromRGBO(204, 45, 202, 0.749);

        case AccentColor.pink:
          return const MacosColor.fromRGBO(229, 74, 145, 0.749);

        case AccentColor.red:
          return const MacosColor.fromRGBO(238, 64, 68, 0.749);

        case AccentColor.orange:
          return const MacosColor.fromRGBO(244, 114, 0, 0.749);

        case AccentColor.yellow:
          return const MacosColor.fromRGBO(233, 176, 0, 0.749);

        case AccentColor.green:
          return const MacosColor.fromRGBO(76, 177, 45, 0.749);

        case AccentColor.graphite:
          return const MacosColor.fromRGBO(129, 129, 122, 0.824);
      }
    }

    if (!isWindowMain) {
      return const MacosColor.fromRGBO(213, 213, 208, 1.0);
    }

    switch (accentColor) {
      case AccentColor.blue:
        return const MacosColor.fromRGBO(9, 129, 255, 0.749);

      case AccentColor.purple:
        return const MacosColor.fromRGBO(162, 28, 165, 0.749);

      case AccentColor.pink:
        return const MacosColor.fromRGBO(234, 81, 152, 0.749);

      case AccentColor.red:
        return const MacosColor.fromRGBO(220, 32, 40, 0.749);

      case AccentColor.orange:
        return const MacosColor.fromRGBO(245, 113, 0, 0.749);

      case AccentColor.yellow:
        return const MacosColor.fromRGBO(240, 180, 2, 0.749);

      case AccentColor.green:
        return const MacosColor.fromRGBO(66, 174, 33, 0.749);

      case AccentColor.graphite:
        return const MacosColor.fromRGBO(174, 174, 167, 0.847);
    }
  }
}
