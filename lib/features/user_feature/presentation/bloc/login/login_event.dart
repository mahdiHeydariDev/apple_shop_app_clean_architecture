class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class LoginSendRequestEvent extends LoginEvent {
  final String identity;
  final String password;
  LoginSendRequestEvent({
    required this.identity,
    required this.password,
  });
}
