import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/register_user_repository.dart';

class RegisterUserUseCase {
  final RegisterUserRepository repository;
  RegisterUserUseCase({required this.repository});
  Future<Either<int, String>> call({required RegisterUserParams params}) async {
    return await repository.registerUser(params: params);
  }
}
