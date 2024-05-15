import 'package:flutter/material.dart';
import 'package:flutter_adaptive/flutter_adaptive.dart';

class MaterialIcons extends AdaptiveBundle {
  MaterialIcons()
      : super(
          builders: {
            MaterialIconBuilder(AdaptiveIcons.home, Icons.home),
            MaterialIconBuilder(AdaptiveIcons.add, Icons.add),
          },
        );
}
