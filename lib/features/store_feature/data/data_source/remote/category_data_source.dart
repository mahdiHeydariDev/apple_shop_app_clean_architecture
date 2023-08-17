import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class CategoryDataSource {
  final Dio _dio;
  CategoryDataSource(this._dio);
  Future<Response> getAllCategories() async {
    try {
      final Response response = await _dio.get(
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

  Future<Response> getCategoryById({required String id}) async {
    final Map<String, dynamic> queryParams = {'filter': 'id="$id"'};
    try {
      final Response response = await _dio.get(
        ConstantsRoutesApi.categoryRoutes,
        queryParameters: queryParams,
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
