class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  CustomError(
    // this.errorCode
    this.message,
    // [this.loggedRequired = false,]
  );
  final String message;
  // final int errorCode;
  // final bool loggedRequired; // Si es true, se debe guardar el error en el log
}
