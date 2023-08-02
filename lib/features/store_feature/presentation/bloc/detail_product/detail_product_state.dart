import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_status.dart';

class DetailProductState {
  final DetailProductStatus status;
  DetailProductState({required this.status});
  DetailProductState setStatus({required DetailProductStatus newStatus}) {
    if (newStatus != status) {
      return DetailProductState(status: newStatus);
    } else {
      return DetailProductState(status: status);
    }
  }
}
