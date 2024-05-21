import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveScaffold extends AdaptiveWidget {
  const AdaptiveScaffold({super.key, this.body, this.appBar});

  final Widget? body;
  final AdaptiveAppBar? appBar;
}
