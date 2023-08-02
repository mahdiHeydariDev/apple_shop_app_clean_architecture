import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/detail_product_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/gallery_image_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_status.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final CategoriesUsecase categoryUsecase;
  final GalleryImagesUsecase galleryImageUsecase;
  final DetailProductUsecase detailProductUsecase;
  DetailProductBloc({
    required this.categoryUsecase,
    required this.galleryImageUsecase,
    required this.detailProductUsecase,
  }) : super(
          DetailProductState(
            status: DetailProductLoadingStatus(),
          ),
        ) {
    on<DetailProductSendRequestEvent>((event, emit) async {
      emit(
        state.setStatus(
          newStatus: DetailProductLoadingStatus(),
        ),
      );
      final Either<CustomError, CategoryEntity> categoryResponse =
          await categoryUsecase.callOneCategory(
        id: event.id,
      );
      final Either<CustomError, List<GalleryImageEntity>>
          galleryImagesResponse = await galleryImageUsecase.call(
        productId: event.productId,
      );
      final Either<CustomError, List<ProductVariantEntity>>
          productVariantsResponse = await detailProductUsecase.callGetVariants(
        productId: event.productId,
      );
      final Either<CustomError, List<PropertyEntity>> propertiesResponse =
          await detailProductUsecase.callGetProperties(
        productId: event.productId,
      );

      if (categoryResponse.isRight() &&
          galleryImagesResponse.isRight() &&
          productVariantsResponse.isRight() &&
          propertiesResponse.isRight()) {
        CategoryEntity? category;
        List<GalleryImageEntity>? galleryImages;
        List<ProductVariantEntity>? productVariants;
        List<PropertyEntity>? properties;

        categoryResponse.fold(
          (l) => null,
          (successCategory) => category = successCategory,
        );
        galleryImagesResponse.fold(
          (l) => null,
          (successGalleryImages) => galleryImages = successGalleryImages,
        );
        productVariantsResponse.fold(
          (l) => null,
          (successProductVariants) => productVariants = successProductVariants,
        );
        propertiesResponse.fold(
          (l) => null,
          (successProperties) => properties = successProperties,
        );
        print(properties);

        emit(
          state.setStatus(
            newStatus: DetailProductSuccessStatus(
              category: category!,
              galleryImages: galleryImages!,
              productVariants: productVariants!,
              properties: properties!,
            ),
          ),
        );
      } else {
        CustomError? error;
        categoryResponse.fold(
          (failedError) => error = failedError,
          (successCategory) => null,
        );
        emit(
          state.setStatus(
            newStatus: DetailProductFailedStatus(
              error: error!,
            ),
          ),
        );
      }
    });
  }
}
