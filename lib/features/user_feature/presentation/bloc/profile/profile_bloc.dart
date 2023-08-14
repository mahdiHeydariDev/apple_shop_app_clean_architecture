import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_status.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SharedPreferences _pref;
  ProfileBloc(this._pref)
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

        final String? token = _pref.getString('token');
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
      await _pref.remove('token');
      emit(
        state.setStaus(
          newStatus: ProfileDoesntLoginStatus(),
        ),
      );
    });
  }
}
