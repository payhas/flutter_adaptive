import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptivePage extends AdaptiveWidget {
  const AdaptivePage(
      {super.key, required this.body, this.appBar, this.bottomBar});

  final Widget body;
  final AdaptiveAppBar? appBar;
  final Widget? bottomBar;
}
