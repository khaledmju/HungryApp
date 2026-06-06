class ApiError {
  final String message;

  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  /// fun to return the message
  @override
  String toString() {
    return message;
  }
}
