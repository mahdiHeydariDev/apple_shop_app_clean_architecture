import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_status.dart';

class RegisterState {
  final RegisterStatus status;
  RegisterState({required this.status});
  RegisterState setStatus({required RegisterStatus newStatus}) {
    if (newStatus != status) {
      return RegisterState(status: newStatus);
    } else {
      return RegisterState(status: status);
    }
  }
}
