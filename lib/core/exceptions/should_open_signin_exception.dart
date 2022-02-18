class ShouldOpenSignInException implements Exception {

  final String? message;

  ShouldOpenSignInException({this.message});

  @override
  String toString() {
    return 'ShouldOpenSignInException{message: $message}';
  }
}
