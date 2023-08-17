import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/core/utils/params/login_user_params.dart';

class LoginUserDataSource {
  final Dio _dio;
  LoginUserDataSource(this._dio);
  Future<Response> loginUser({required LoginUserParams params}) async {
    final Map<dynamic, dynamic> sentData = {
      'identity': params.identity,
      'password': params.password,
    };
    try {
      final Response response = await _dio.post(
        ConstantsRoutesApi.userLoginRoutes,
        data: sentData,
      );
      return response;
    } on DioException catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.response!.statusMessage!,
        exceptionCode: exception.response!.statusCode!,
      );
    } catch (exception) {
      throw UknownError();
    }
  }
}
