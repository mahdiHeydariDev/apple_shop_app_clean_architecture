import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';

class PropertyModel extends PropertyEntity {
  const PropertyModel({
    required String id,
    required String productId,
    required String title,
    required String value,
  }) : super(
          id: id,
          productId: productId,
          title: title,
          value: value,
        );
  factory PropertyModel.fromMapJson(Map<String, dynamic> mapJson) {
    return PropertyModel(
      id: mapJson['id'],
      productId: mapJson['product_id'],
      title: mapJson['title'],
      value: mapJson['value'],
    );
  }
}
