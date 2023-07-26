import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required String color,
    required String icon,
    required String id,
    required String thumbnail,
    required String title,
  }) : super(
          color: color,
          icon: icon,
          id: id,
          thumbnail: thumbnail,
          title: title,
        );
  factory CategoryModel.fromMapJson(Map<String, dynamic> mapJson) {
    return CategoryModel(
      color: mapJson['color'],
      icon:
          'http://startflutter.ir/api/files/${mapJson['collectionId']}/${mapJson['id']}/${mapJson['thumbnail']}',
      id: mapJson['id'],
      thumbnail:
          'http://startflutter.ir/api/files/${mapJson['collectionId']}/${mapJson['id']}/${mapJson['thumbnail']}',
      title: mapJson['title'],
    );
  }
}
