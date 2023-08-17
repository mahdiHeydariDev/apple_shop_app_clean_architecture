import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class ProductsDataSource {
  final Dio _dio;
  ProductsDataSource(this._dio);
  Future<Response> getFilteredProducts({required String filter}) async {
    final Map<String, String> queryParams = {'filter': 'popularity="$filter"'};
    try {
      final Response response = await _dio.get(
        ConstantsRoutesApi.productsRoutes,
        queryParameters: queryParams,
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
