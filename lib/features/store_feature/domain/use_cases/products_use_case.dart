import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/products_repository_impl.dart';

class ProductsUsecase {
  final ProductsRepositoryImpl _repository;
  ProductsUsecase({required ProductsRepositoryImpl repository})
      : _repository = repository;
  Future<Either<CustomError, List<ProductEntity>>> call(
      {required String filter}) async {
    return await _repository.getFilteredProducts(filter: filter);
  }
}
