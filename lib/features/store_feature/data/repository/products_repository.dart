import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<CustomError, List<ProductEntity>>> getFilteredProducts({
    required String filter,
  });
}
