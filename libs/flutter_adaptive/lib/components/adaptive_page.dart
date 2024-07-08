import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptivePage extends AdaptiveWidget {
  const AdaptivePage(
      {super.key, required this.child, this.appBar, this.bottomBar});

  final Widget child;
  final AdaptiveAppBar? appBar;
  final Widget? bottomBar;
}
