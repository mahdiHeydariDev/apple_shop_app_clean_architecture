import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/categories_repository_impl.dart';

class CategoriesUsecase {
  final CategoriesRepositoryImpl repository;
  CategoriesUsecase({required this.repository});

  Future<Either<CustomError, List<CategoryEntity>>> call() async {
    return await repository.getAllCategories();
  }
}
