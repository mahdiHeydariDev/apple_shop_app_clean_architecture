import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/products_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/product_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/products_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSource dataSource;
  ProductsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<CustomError, List<ProductEntity>>> getFilteredProducts({
    required String filter,
  }) async {
    try {
      final Response dataSourceResponse =
          await dataSource.getFilteredProducts(filter: filter);
      if (dataSourceResponse.statusCode == 200) {
        final List<ProductEntity> productsList =
            (dataSourceResponse.data['items'] as List)
                .map<ProductEntity>(
                  (mapJson) => ProductModel.fromMapJson(mapJson),
                )
                .toList();
        return Right(productsList);
      } else {
        return Left(
          CustomError(
            header: ApiText.networkHeader,
            description: ApiText.networkDescription,
          ),
        );
      }
    } on ApiEception catch (_) {
      return Left(
        CustomError(
          header: ApiText.networkHeader,
          description: ApiText.networkDescription,
        ),
      );
    } on UknownError catch (_) {
      return Left(
        CustomError(
          header: ApiText.networkHeader,
          description: ApiText.networkDescription,
        ),
      );
    } catch (_) {
      return Left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    }
  }
}
