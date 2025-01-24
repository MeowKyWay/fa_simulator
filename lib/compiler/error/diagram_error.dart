abstract class DiagramErrors<T> {
  final List<T> errors;

  DiagramErrors({
    required this.errors,
  });

  T? isError(T type) {
    return errors.contains(type) ? type : null;
  }

  bool get hasError => errors.isNotEmpty;

  void addError(T error) {
    errors.add(error);
  }
}
