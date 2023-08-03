import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/categories_repository_impl.dart';

class CategoriesUsecase {
  final CategoriesRepositoryImpl repository;
  CategoriesUsecase({required this.repository});

  Future<Either<CustomError, List<CategoryEntity>>> callAllCategories() async {
    return await repository.getAllCategories();
  }

  Future<Either<CustomError, CategoryEntity>> callOneCategory(
      {required String id}) async {
    return await repository.getCategoryById(id: id);
  }
}
