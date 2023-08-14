import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_status.dart';

class ProfileState {
  ProfileStatus status;
  ProfileState({required this.status});

  ProfileState setStaus({required ProfileStatus newStatus}) {
    return ProfileState(status: newStatus);
  }
}
