import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/gallery_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/gallery_image_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/gallery_product_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';

class GalleryProductRepositoryImpl extends GalleryProductRepository {
  final GalleryProductDataSource dataSource;
  GalleryProductRepositoryImpl({required this.dataSource});
  @override
  Future<Either<CustomError, List<GalleryImageEntity>>> getAllImages(
      {required String productId}) async {
    try {
      //TODO Searching for a way to automatically create lists
      final Response datasourceResponse = await dataSource.getImages(
        productId: productId,
      );

      if (datasourceResponse.statusCode == 200) {
        final List<GalleryImageEntity> galleryList =
            (datasourceResponse.data['items'] as List)
                .map<GalleryImageEntity>(
                  (mapJson) => GalleryImageModel.fromMapJson(mapJson),
                )
                .toList();
        return Right(galleryList);
      } else {
        return Left(
          CustomError(
            header: ApiText.networkHeader,
            description: ApiText.networkDescription,
          ),
        );
      }
    } on ApiEception catch (_) {
      return Left(
        CustomError(
          header: ApiText.networkHeader,
          description: ApiText.networkDescription,
        ),
      );
    } catch (_) {
      return Left(
        CustomError(
            header: ApiText.uknownHeader,
            description: ApiText.uknownDescription),
      );
    }
  }
}
