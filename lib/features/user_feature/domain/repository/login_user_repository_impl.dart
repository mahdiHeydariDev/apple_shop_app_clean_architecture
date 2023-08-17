import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/core/utils/params/login_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/data_source/remote/login_user_data_source.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/login_user_repository.dart';

class LoginUserRepositoryImpl extends LoginUserRepository {
  final LoginUserDataSource _dataSource;
  LoginUserRepositoryImpl({required LoginUserDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<int, String>> loginUser(
      {required LoginUserParams sentParams}) async {
    try {
      final Response dataSourceResponse =
          await _dataSource.loginUser(params: sentParams);
      if (dataSourceResponse.statusCode == 200) {
        return Right(dataSourceResponse.data['token']);
      } else {
        return const Left(0);
      }
    } on ApiEception catch (apiException) {
      return Left(apiException.exceptionCode);
    } on UknownError catch (_) {
      return const Left(0);
    } catch (_) {
      return const Left(0);
    }
  }
}
