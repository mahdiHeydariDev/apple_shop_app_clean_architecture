import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';

abstract class GalleryProductRepository {
  Future<Either<CustomError, List<GalleryImageEntity>>> getAllImages(
      {required String productId});
}
