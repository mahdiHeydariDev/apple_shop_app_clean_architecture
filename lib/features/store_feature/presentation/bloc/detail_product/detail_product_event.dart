import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';

class DetailProductEvent {}

class DetailProductSendRequestEvent extends DetailProductEvent {
  final String id;
  final String productId;
  DetailProductSendRequestEvent({
    required this.id,
    required this.productId,
  });
}

class DetailProductAddToBasketEvent extends DetailProductEvent {
  final ProductEntity product;
  final List<ProductVariantEntity> variants;
  DetailProductAddToBasketEvent({
    required this.product,
    required this.variants,
  });
}
