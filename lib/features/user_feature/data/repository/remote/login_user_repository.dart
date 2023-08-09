import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/params/login_user_params.dart';

abstract class LoginUserRepository {
  Future<Either<int, String>> loginUser({required LoginUserParams sentParams});
}
