import 'package:flutter/material.dart';

import '../base/adaptive_widget.dart';

class AdaptiveAppBar extends AdaptiveWidget {
  const AdaptiveAppBar({
    super.key,
    this.title,
  });

  final Widget? title;
}
