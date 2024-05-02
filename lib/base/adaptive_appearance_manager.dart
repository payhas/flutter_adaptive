abstract class AdaptiveAppearanceManager<T> {
  String get name => runtimeType.toString();

  String get appearanceName;
  T? get initialValue;

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveAppearanceManager) {
      return name == other.name;
    }

    return false;
  }
}
