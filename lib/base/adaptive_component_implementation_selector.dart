abstract class AdaptiveComponentImplementationSelector<T> {
  String get name => runtimeType.toString();

  T? select(
    String componentName,
    Set<T>? componentList,
    Map<String, dynamic> appearance,
  );

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is AdaptiveComponentImplementationSelector) {
      return name == other.name;
    }

    return false;
  }
}
