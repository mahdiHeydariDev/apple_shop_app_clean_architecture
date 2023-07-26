import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required String? categoryId,
    required String? thumbnail,
  }) : super(
          categoryId: categoryId,
          thumbnail: thumbnail,
        );
  factory BannerModel.fromMapJson(Map<String, dynamic> mapJson) {
    return BannerModel(
      categoryId: mapJson['categoryId'],
      thumbnail:
          'http://startflutter.ir/api/files/${mapJson['collectionId']}/${mapJson['id']}/${mapJson['thumbnail']}',
    );
  }
}
