import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_clean_architecture/core/utils/params/login_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/use_case/login_user_use_case.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/login/login_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase _useCase;
  final SharedPreferences _pref;
  LoginBloc(
    this._useCase,
    this._pref,
  ) : super(
          LoginState(
            status: LoginInitStatus(),
          ),
        ) {
    on<LoginInitEvent>((event, emit) {
      state.setStatus(
        newStatus: LoginInitStatus(),
      );
    });
    on<LoginSendRequestEvent>(
      (event, emit) async {
        emit(
          state.setStatus(
            newStatus: LoginLoadingStatus(),
          ),
        );
        final LoginUserParams sentParams = LoginUserParams(
          identity: event.identity,
          password: event.password,
        );
        final Either<int, String> response =
            await _useCase.call(sentParams: sentParams);
        if (response.isRight()) {
          String? userToken;
          response.fold((l) => null, (token) => userToken = token);

          await _pref.setString('token', userToken!);
          print(_pref.get('token'));

          emit(
            state.setStatus(
              newStatus: LoginSuccessResponseStatus(),
            ),
          );
        } else if (response.isLeft()) {
          int errorCode = 0;
          response.fold((error) => errorCode = error, (r) => null);
          if (errorCode == 400) {
            emit(
              state.setStatus(
                newStatus: LoginInitStatus(error: errorCode),
              ),
            );
          } else {
            emit(
              state.setStatus(
                newStatus: LoginFailedResponseStatus(error: 0),
              ),
            );
          }
        }
      },
    );
  }
}
