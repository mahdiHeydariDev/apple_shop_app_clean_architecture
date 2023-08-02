import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/gallery_product_repository_impl.dart';

class GalleryImagesUsecase {
  final GalleryProductRepositoryImpl repository;
  GalleryImagesUsecase({required this.repository});

  Future<Either<CustomError, List<GalleryImageEntity>>> call(
      {required String productId}) async {
    return await repository.getAllImages(
      productId: productId,
    );
  }
}
