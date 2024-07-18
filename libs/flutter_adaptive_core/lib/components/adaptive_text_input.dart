import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';
import 'package:flutter/widgets.dart';

class AdaptiveTextInput extends AdaptiveWidget {
  const AdaptiveTextInput({
    super.key,
    this.placeholder,
    this.controller,
    this.onChanged,
  });

  final String? placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
}
