import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategoriesStatus {}

class CategoriesLoadingStatus extends CategoriesStatus {}

class CategoriesSuccessStatus extends CategoriesStatus {
  final List<CategoryEntity> categoriesResponse;
  CategoriesSuccessStatus({required this.categoriesResponse});
}

class CategoriesFailedStatus extends CategoriesStatus {
  final CustomError error;
  CategoriesFailedStatus({required this.error});
}
