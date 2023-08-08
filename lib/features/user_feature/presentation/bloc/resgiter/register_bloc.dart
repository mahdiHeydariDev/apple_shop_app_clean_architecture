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
    on<RegisterSendRequestEvent>(
      (event, emit) async {
        emit(
          state.setStatus(
            newStatus: RegisterLoadingStatus(),
          ),
        );
        final RegisterUserParams params = RegisterUserParams(
          userName: event.userName,
          password: event.password,
          confirmPassword: event.passwordConfirm,
        );
        final Either<String, String> response =
            await useCase.call(params: params);
        if (response.isRight()) {
          emit(
            state.setStatus(
              newStatus: RegisterSuccessResponseStatus(success: ''),
            ),
          );
        } else {
          emit(
            state.setStatus(
              newStatus: RegisterFailedResponseStatus(error: ''),
            ),
          );
        }
      },
    );
  }
}
