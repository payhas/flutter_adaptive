import 'package:flutter/cupertino.dart';

import 'master_detail_page.dart';
import 'master_tile.dart';
import 'master_detail_theme.dart';
import 'scroll_view_undershoot.dart';

class MasterListView extends StatefulWidget {
  const MasterListView({
    super.key,
    required this.length,
    required this.selectedIndex,
    required this.builder,
    required this.onTap,
    required this.availableWidth,
    this.startUndershoot = true,
    this.endUndershoot = true,
  });

  final int length;
  final MasterTileBuilder builder;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final double availableWidth;
  final bool startUndershoot;
  final bool endUndershoot;

  @override
  State<MasterListView> createState() => _MasterListViewState();
}

class _MasterListViewState extends State<MasterListView> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MasterDetailTheme.of(context);
    return ScrollViewUndershoot(
      controller: _controller,
      startUndershoot: widget.startUndershoot,
      endUndershoot: widget.endUndershoot,
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: theme.listPadding ?? EdgeInsets.zero,
              child: Column(
                children: List.generate(
                  widget.length,
                  (index) => MasterTileScope(
                    index: index,
                    selected: index == widget.selectedIndex,
                    onTap: () => widget.onTap(index),
                    child: Builder(
                      builder: (context) => widget.builder(
                        context,
                        index,
                        index == widget.selectedIndex,
                        widget.availableWidth,
                      ),
                    ),
                  ),
                ).withSpacing(theme.tileSpacing ?? 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on List<Widget> {
  List<Widget> withSpacing(double height) => expand((item) sync* {
        yield SizedBox(height: height);
        yield item;
      }).skip(1).toList();
}
