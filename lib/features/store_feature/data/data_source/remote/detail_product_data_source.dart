import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_routes/constants_api_routs.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';

class DetailProductDatasource {
  final Dio dio;
  DetailProductDatasource({required this.dio});
  Future<Response> getVariantTypes() async {
    try {
      final Response response = await dio.get(
        ConstantsRoutesApi.variantTypesRoutes,
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

  Future<Response> getVariants({required String productId}) async {
    final Map<String, String> queryParams = {
      'filter': 'product_id="$productId"'
    };
    try {
      final Response response = await dio.get(
        ConstantsRoutesApi.variantsRoutes,
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

  Future<Response> getProperties({required String productId}) async {
    final Map<String, String> queryParams = {
      'filter': 'product_id="$productId"'
    };
    try {
      final Response response = await dio.get(
        ConstantsRoutesApi.propertiesRoutes,
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
