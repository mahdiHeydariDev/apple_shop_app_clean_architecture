import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';

class VariantModel extends VariantEntity {
  const VariantModel({
    required String id,
    required String name,
    required int priceChange,
    required String productId,
    required String typeId,
    required String value,
  }) : super(
          id: id,
          name: name,
          priceChange: priceChange,
          productId: productId,
          typeId: typeId,
          value: value,
        );
  factory VariantModel.fromMapJson(Map<String, dynamic> mapJson) {
    return VariantModel(
      id: mapJson['id'],
      name: mapJson['name'],
      priceChange: mapJson['price_change'],
      productId: mapJson['product_id'],
      typeId: mapJson['type_id'],
      value: mapJson['value'],
    );
  }
}
