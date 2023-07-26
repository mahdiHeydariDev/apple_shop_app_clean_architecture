class ApiEception implements Exception {
  final String exceptionMessage;
  final int exceptionCode;
  const ApiEception({
    required this.exceptionMessage,
    required this.exceptionCode,
  });
}
