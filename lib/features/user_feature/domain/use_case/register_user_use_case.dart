import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/register_user_repository.dart';

class RegisterUserUseCase {
  final RegisterUserRepository _repository;
  RegisterUserUseCase({required RegisterUserRepository repository})
      : _repository = repository;
  Future<Either<int, String>> call({required RegisterUserParams params}) async {
    return await _repository.registerUser(params: params);
  }
}
