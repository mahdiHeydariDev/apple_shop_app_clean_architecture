import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_status.dart';

class BasketState {
  BasketStatus status;
  BasketState({required this.status});
  BasketState setStatus(BasketStatus newStatus) {
    return BasketState(status: newStatus);
  }
}
