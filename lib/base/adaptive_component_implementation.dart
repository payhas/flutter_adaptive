abstract class AdaptiveComponentImplementation<T> {
  String get name => runtimeType.toString();
  String get componentName => (T).toString();

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveComponentImplementation) {
      return name == other.name;
    }

    return false;
  }
}
