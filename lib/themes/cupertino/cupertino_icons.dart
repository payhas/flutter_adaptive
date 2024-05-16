import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter_adaptive/flutter_adaptive.dart';

class CupertinoIcons extends AdaptiveBundle {
  CupertinoIcons()
      : super(
          builders: {
            CupertinoIconBuilder(AdaptiveIcons.home, ios.CupertinoIcons.home),
            CupertinoIconBuilder(AdaptiveIcons.add, ios.CupertinoIcons.add),
          },
        );
}
