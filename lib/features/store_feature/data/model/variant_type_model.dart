import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_type_entity.dart';

class VariantTypeModel extends VariantTypeEntity {
  const VariantTypeModel({
    required String id,
    required String name,
    required String title,
    required String type,
  }) : super(
          id: id,
          name: name,
          title: title,
          type: type,
        );
  factory VariantTypeModel.fromMapJson(Map<String, dynamic> mapJson) {
    return VariantTypeModel(
      id: mapJson['id'],
      name: mapJson['name'],
      title: mapJson['title'],
      type: mapJson['type'],
    );
  }
}
