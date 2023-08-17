import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class GalleryProductDataSource {
  final Dio _dio;
  GalleryProductDataSource(this._dio);
  Future<Response> getImages({required String productId}) async {
    final Map<String, dynamic> queryParams = {
      'filter': 'product_id="$productId"',
    };
    try {
      final Response response = await _dio.get(
        ConstantsRoutesApi.galleryRoutes,
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
