import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/data_source/remote/register_user_data_source.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/register_user_repository.dart';

class RegisterUserRepositoryImpl extends RegisterUserRepository {
  final RegisterUserDataSource dataSource;
  RegisterUserRepositoryImpl({required this.dataSource});
  @override
  Future<Either<String, String>> registerUser(
      {required RegisterUserParams params}) async {
    try {
      final Response dataSourceResponse =
          await dataSource.registerUser(params: params);
      if (dataSourceResponse.statusCode == 200) {
        return const Right('Success');
      } else {
        return const Left('Failed');
      }
    } on ApiEception catch (_) {
      return const Right('Failed');
    } on UknownError catch (_) {
      return const Right('Failed');
    } catch (_) {
      return const Right('Failed');
    }
  }
}
