class StateHasTransitionsException implements Exception {
  final String message;
  StateHasTransitionsException(this.message);

  @override
  String toString() => 'StateHasTransitionsException: $message';
}
