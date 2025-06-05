class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  CustomError(this.message, this.errorCode);
  final String message;
  final int errorCode;
}
