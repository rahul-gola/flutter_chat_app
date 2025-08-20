class BaseError implements Exception {
  BaseError({
    required this.cause,
    required this.message,
  });
  final Exception cause;
  final String message;

  String getFriendlyMessage() {
    return message;
  }
}
