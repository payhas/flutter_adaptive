import 'package:flutter_adaptive/flutter_adaptive.dart';

class AdaptiveCircularProgressIndicator extends AdaptiveWidget {
  const AdaptiveCircularProgressIndicator({
    super.key,
    required this.value,
  });

  final double? value;
}
