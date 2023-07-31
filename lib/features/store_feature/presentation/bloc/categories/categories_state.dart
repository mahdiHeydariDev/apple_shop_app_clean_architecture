import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_status.dart';

class CategoriesState {
  CategoriesStatus status;
  CategoriesState({required this.status});
  CategoriesState setStatus({required CategoriesStatus newStatus}) {
    if (newStatus != status) {
      return CategoriesState(status: newStatus);
    } else {
      return CategoriesState(status: status);
    }
  }
}
