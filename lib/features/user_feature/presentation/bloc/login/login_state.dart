import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_status.dart';

class LoginState {
  final LoginStatus status;
  LoginState({required this.status});
  LoginState setStatus({required LoginStatus newStatus}) {
    return LoginState(status: newStatus);
  }
}
