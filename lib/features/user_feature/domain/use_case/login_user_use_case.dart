import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/params/login_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/login_user_repository.dart';

class LoginUserUseCase {
  final LoginUserRepository _repository;
  LoginUserUseCase(this._repository);
  Future<Either<int, String>> call(
      {required LoginUserParams sentParams}) async {
    return await _repository.loginUser(sentParams: sentParams);
  }
}
