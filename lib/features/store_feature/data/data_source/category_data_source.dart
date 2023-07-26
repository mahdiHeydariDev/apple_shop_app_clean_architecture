import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class CategoryDataSource {
  final Dio dio;
  CategoryDataSource({required this.dio});
  Future<Response> getAllCategories() async {
    try {
      final Response response = await dio.get(
        ConstantsRoutesApi.categoryRoutes,
      );
      return response;
    } on DioException catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.response!.statusMessage!,
        exceptionCode: exception.response!.statusCode!,
      );
    } catch (_) {
      throw UknownError();
    }
  }
}
