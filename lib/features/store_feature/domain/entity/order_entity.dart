import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
part 'order_entity.g.dart';

@HiveType(typeId: 1)
class OrderEntity extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String warranty;
  @HiveField(3)
  final String mainImageUrl;
  @HiveField(4)
  final int realPrice;
  @HiveField(5)
  final int discountPrice;
  @HiveField(6)
  final int finalPrice;
  @HiveField(7)
  int count;
  @HiveField(8)
  final List<ProductVariantEntity> productVariants;
  OrderEntity({
    required this.id,
    required this.name,
    required this.warranty,
    required this.mainImageUrl,
    required this.realPrice,
    required this.discountPrice,
    required this.finalPrice,
    required this.count,
    required this.productVariants,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        warranty,
        mainImageUrl,
        realPrice,
        discountPrice,
        finalPrice,
        count,
        productVariants,
      ];
}
