import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/use_case/register_user_use_case.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_event.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_state.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_status.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase useCase;
  RegisterBloc({required this.useCase})
      : super(
          RegisterState(
            status: RegisterInitStatus(),
          ),
        ) {
    on<RegisterInitEvent>((event, emit) {
      emit(
        state.setStatus(
          newStatus: RegisterInitStatus(),
        ),
      );
    });
    on<RegisterSendRequestEvent>(
      (event, emit) async {
        if (event.userName.length <= 4) {
          emit(
            state.setStatus(
              newStatus: RegisterInitStatus(errorCode: 1),
            ),
          );
        } else if (event.password.length <= 7) {
          emit(
            state.setStatus(
              newStatus: RegisterInitStatus(errorCode: 2),
            ),
          );
        } else if (event.password != event.passwordConfirm) {
          emit(
            state.setStatus(
              newStatus: RegisterInitStatus(errorCode: 3),
            ),
          );
        } else if (event.userName.length >= 5 &&
            event.password.length >= 8 &&
            event.password == event.passwordConfirm) {
          final RegisterUserParams params = RegisterUserParams(
            userName: event.userName,
            password: event.password,
            confirmPassword: event.passwordConfirm,
          );
          emit(
            state.setStatus(
              newStatus: RegisterLoadingStatus(),
            ),
          );
          final Either<int, String> response =
              await useCase.call(params: params);
          if (response.isRight()) {
            emit(
              state.setStatus(
                newStatus: RegisterSuccessResponseStatus(success: ''),
              ),
            );
          } else {
            int errorCode = 0;
            response.fold((error) => errorCode = error, (r) => null);

            emit(
              state.setStatus(
                newStatus: RegisterInitStatus(errorCode: errorCode),
              ),
            );
          }
        }
      },
    );
  }
}
