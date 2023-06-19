class AppException implements Exception {
  final String? message;
  final String prefix;

  AppException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix${message ?? ''}";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}

class TimeoutRequestException extends AppException {
  TimeoutRequestException([message]) : super(message, "Timeout issue: ");
}

class NoNetworkException extends AppException {
  NoNetworkException([message])
      : super(message, "Please connect to internet and try again.");
}
