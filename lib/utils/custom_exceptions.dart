class HttpException implements Exception {
  final int statusCode;
  String message;

  HttpException(this.statusCode) {
    switch (statusCode) {
      case 400:
        message = 'Invalid login credentials!';
        break;
      case 404:
        message = 'Item does not exist!';
        break;
      case 500:
        message = 'Internal server error occurred!';
        break;
      default:
        message = 'Oops! Error $statusCode occurred.';
        break;
    }
  }

  @override
  String toString() => message;
}
