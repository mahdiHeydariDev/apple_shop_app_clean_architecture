class RegisterStatus {}

class RegisterInitStatus extends RegisterStatus {
  int errorCode;
  RegisterInitStatus({this.errorCode = 0});
  RegisterInitStatus changeCode({required int code}) {
    return RegisterInitStatus(errorCode: code);
  }
}

class RegisterLoadingStatus extends RegisterStatus {}

class RegisterSuccessResponseStatus extends RegisterStatus {
  final String success;
  RegisterSuccessResponseStatus({required this.success});
}

class RegisterFailedResponseStatus extends RegisterStatus {
  final int error;
  RegisterFailedResponseStatus({required this.error});
}
