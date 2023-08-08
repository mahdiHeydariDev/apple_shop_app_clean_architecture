class RegisterStatus {}

class RegisterInitStatus extends RegisterStatus {}

class RegisterLoadingStatus extends RegisterStatus {}

class RegisterSuccessResponseStatus extends RegisterStatus {
  final String success;
  RegisterSuccessResponseStatus({required this.success});
}

class RegisterFailedResponseStatus extends RegisterStatus {
  final String error;
  RegisterFailedResponseStatus({required this.error});
}
