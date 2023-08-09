class LoginStatus {}

class LoginInitStatus extends LoginStatus {
  int error;
  LoginInitStatus({this.error = 0});
  LoginInitStatus changeCode({required int errorCode}) {
    return LoginInitStatus(error: errorCode);
  }
}

class LoginLoadingStatus extends LoginStatus {}

class LoginSuccessResponseStatus extends LoginStatus {}

class LoginFailedResponseStatus extends LoginStatus {
  final int error;
  LoginFailedResponseStatus({required this.error});
}
