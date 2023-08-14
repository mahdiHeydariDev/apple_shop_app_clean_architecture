import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_status.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(
          ProfileState(
            status: ProfileInitStatus(),
          ),
        ) {
    on<ProfileCheckSessionEvent>(
      (event, emit) async {
        emit(
          state.setStaus(
            newStatus: ProfileLoadingStatus(),
          ),
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token');
        if (token != null) {
          emit(
            state.setStaus(
              newStatus: ProfileLoginStatus(),
            ),
          );
        } else {
          emit(
            state.setStaus(
              newStatus: ProfileDoesntLoginStatus(),
            ),
          );
        }
      },
    );
    on<ProfileLogoutSessionEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      emit(
        state.setStaus(
          newStatus: ProfileDoesntLoginStatus(),
        ),
      );
    });
  }
}
