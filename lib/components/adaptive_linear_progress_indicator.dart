import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveLinearProgressIndicator extends AdaptiveWidget {
  const AdaptiveLinearProgressIndicator({
    super.key,
    required this.value,
  });

  final double? value;
}
