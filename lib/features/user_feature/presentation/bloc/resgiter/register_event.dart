class RegisterEvent {}

class RegisterSendRequestEvent extends RegisterEvent {
  final String userName;
  final String password;
  final String passwordConfirm;
  RegisterSendRequestEvent({
    required this.userName,
    required this.password,
    required this.passwordConfirm,
  });
}
