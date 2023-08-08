import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/core/utils/params/register_user_params.dart';

class RegisterUserDataSource {
  final Dio dio;
  RegisterUserDataSource({required this.dio});
  Future<Response> registerUser({required RegisterUserParams params}) async {
    final Map<String, String> data = {
      'username': params.userName,
      'password': params.password,
      'passwordConfirm': params.confirmPassword,
    };
    try {
      final Response response = await dio.post(
        ConstantsRoutesApi.userRegisterRoutes,
        data: data,
      );
      return response;
    } on DioException catch (exception) {
      //If the connection was not successful
      throw ApiEception(
        exceptionMessage: exception.response!.statusMessage!,
        exceptionCode: exception.response!.statusCode!,
      );
    } catch (anotherException) {
      //If an unknown error occurs
      throw UknownError();
    }
  }
}
