class AppException implements Exception {
  final String message;

  AppException([this.message = "An unknown error occurred"]);

  @override
  String toString() {
    return message;
  }

  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException("An unknown exception occurred.");
  }
}

class UnknownException extends AppException {
  UnknownException([super.message]);
}
