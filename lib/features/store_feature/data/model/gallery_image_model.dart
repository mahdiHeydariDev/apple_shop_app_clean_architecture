import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';

class GalleryImageModel extends GalleryImageEntity {
  GalleryImageModel({
    required String imageId,
    required String imageUrl,
  }) : super(
          imageId: imageId,
          imageUrl: imageUrl,
        );
  factory GalleryImageModel.fromMapJson(Map<String, dynamic> mapJson) {
    return GalleryImageModel(
      imageId: mapJson['id'],
      imageUrl:
          'http://startflutter.ir/api/files/${mapJson['collectionId']}/${mapJson['id']}/${mapJson['image']}',
    );
  }
}
