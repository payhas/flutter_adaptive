import 'package:flutter/widgets.dart';

import 'adaptive.dart';

abstract class AdaptiveWidget extends StatelessWidget {
  String get name => runtimeType.toString();

  const AdaptiveWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var builder = Adaptive.of(context)?.getBuilder(name);
    return builder?.build(context, this) ?? const SizedBox.shrink();
  }
}
