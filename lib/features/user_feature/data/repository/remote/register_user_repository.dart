import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';

abstract class RegisterUserRepository {
  Future<Either<String, String>> registerUser(
      {required RegisterUserParams params});
}
