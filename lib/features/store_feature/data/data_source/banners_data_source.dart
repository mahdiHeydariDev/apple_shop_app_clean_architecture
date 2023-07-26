import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class BannersDataSource {
  final Dio dio;
  BannersDataSource({required this.dio});
  Future<Response> getAllBanners() async {
    try {
      //get data from : http://startflutter.ir/api/collections/banner/records
      final Response response = await dio.get(
        ConstantsRoutesApi.bannersRoutes,
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
