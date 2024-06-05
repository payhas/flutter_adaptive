import 'package:fluent_ui/fluent_ui.dart';

/// Define the side placement of a [YaruPanedView] pane.
enum PaneSide {
  /// Place pane at top side.
  top,

  /// Place pane at bottom side.
  bottom,

  /// Place pane at left side.
  left,

  /// Place pane at right side.
  right,

  /// [TextDirection] aware pane placement.
  /// Left side in [TextDirection.ltr] contexts,
  /// and right side in [TextDirection.rtl] contexts.
  start,

  /// [TextDirection] aware pane placement.
  /// Right side in [TextDirection.ltr] contexts,
  /// and left side in [TextDirection.rtl] contexts.
  end;

  bool get isVertical => this == top || this == bottom;
  bool get isHorizontal =>
      this == left || this == right || this == start || this == end;
}

/// Layout delegate interface which controls a [YaruPanedView] pane size, side and resizing capacity.
abstract class PanedViewLayoutDelegate {
  const PanedViewLayoutDelegate();

  bool get allowPaneResizing;
  PaneSide get paneSide;

  double calculatePaneSize({
    required double availableSpace,
    required double? candidatePaneSize,
  });
}

/// Controls a [YaruPanedView] pane with a fixed size.
class FixedPaneDelegate implements PanedViewLayoutDelegate {
  /// Controls a [YaruPanedView] pane with a fixed size.
  const FixedPaneDelegate({
    required this.paneSize,
    this.paneSide = PaneSide.start,
  });

  /// Fixed size of the pane.
  final double paneSize;

  // Side placement of the pane.
  @override
  final PaneSide paneSide;

  @override
  bool get allowPaneResizing => false;

  @override
  double calculatePaneSize({
    required double availableSpace,
    required double? candidatePaneSize,
  }) {
    // Security in case of a very large [paneSize].
    if (paneSize > availableSpace / 2) {
      return availableSpace / 2;
    }

    return paneSize;
  }
}

/// Controls a [YaruPanedView] pane with a resizable size.
class ResizablePaneDelegate implements PanedViewLayoutDelegate {
  /// Controls a [YaruPanedView] pane with a resizable size.
  const ResizablePaneDelegate({
    required this.initialPaneSize,
    required this.minPaneSize,
    required this.minPageSize,
    this.paneSide = PaneSide.start,
  });

  final double initialPaneSize;

  /// Min size of a [YaruPanedView] pane.
  /// [minPaneSize] has priority on this value.
  final double minPaneSize;

  /// Min size of a [YaruPanedView] page.
  /// This value has priority on [minPaneSize].
  final double minPageSize;

  // Side placement of the pane.
  @override
  final PaneSide paneSide;

  @override
  bool get allowPaneResizing => true;

  @override
  double calculatePaneSize({
    required double availableSpace,
    required double? candidatePaneSize,
  }) {
    final maxSize = availableSpace - minPageSize;
    candidatePaneSize = candidatePaneSize ?? initialPaneSize;

    if (candidatePaneSize >= maxSize) {
      return maxSize;
    } else if (candidatePaneSize < minPaneSize) {
      return minPaneSize;
    } else {
      return candidatePaneSize;
    }
  }
}
