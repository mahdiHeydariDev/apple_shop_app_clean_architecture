import 'package:equatable/equatable.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_type_entity.dart';

class ProductVariantEntity extends Equatable {
  final VariantTypeEntity variantType;
  final List<VariantEntity> variants;

  const ProductVariantEntity({
    required this.variantType,
    required this.variants,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        variantType,
        variants,
      ];
}
