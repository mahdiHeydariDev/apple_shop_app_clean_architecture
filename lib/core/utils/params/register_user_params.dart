class RegisterUserParams {
  final String userName;
  final String password;
  final String confirmPassword;
  const RegisterUserParams({
    required this.userName,
    required this.password,
    required this.confirmPassword,
  });
}
