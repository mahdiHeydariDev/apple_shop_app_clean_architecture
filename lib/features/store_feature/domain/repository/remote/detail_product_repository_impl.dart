import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/detail_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/property_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/variant_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/variant_type_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/detail_product_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_type_entity.dart';

class DetailProductRepositoryImpl extends DetailProductRepository {
  final DetailProductDatasource _dataSource;
  DetailProductRepositoryImpl(this._dataSource);
  @override
  Future<List<VariantTypeEntity>> getAllVariantTypes() async {
    try {
      final Response dataSourceResponse = await _dataSource.getVariantTypes();

      final List<VariantTypeEntity> variantTypeList =
          (dataSourceResponse.data['items'] as List)
              .map<VariantTypeEntity>(
                (mapJson) => VariantTypeModel.fromMapJson(mapJson),
              )
              .toList();
      return variantTypeList;
    } catch (exception) {
      throw const ApiEception(
        exceptionMessage: 'network error',
        exceptionCode: 0,
      );
    }
  }

  @override
  Future<List<VariantEntity>> getVariants({required String productId}) async {
    final Response dataSourceResponse =
        await _dataSource.getVariants(productId: productId);

    final List<VariantEntity> variantsList =
        (dataSourceResponse.data['items'] as List)
            .map<VariantEntity>(
              (mapJson) => VariantModel.fromMapJson(mapJson),
            )
            .toList();
    return variantsList;
  }

  @override
  Future<Either<CustomError, List<ProductVariantEntity>>> getProductVariants(
      {required String productId}) async {
    try {
      //first we recive all variants from server
      final List<VariantTypeEntity> variantTypes = await getAllVariantTypes();
      final List<VariantEntity> variants =
          await getVariants(productId: productId);
      //now we use it to return a list of ProductVariants
      final List<ProductVariantEntity> productVariantsResponse = [];
      for (var i = 0; i < variantTypes.length; i += 1) {
        List<VariantEntity> newVariants = [];
        //found variants which is equal with variant type[i] id
        newVariants = variants
            .where((variant) => variant.typeId == variantTypes[i].id)
            .toList();
        //add a productVariant to response list
        productVariantsResponse.add(
          ProductVariantEntity(
            variantType: variantTypes[i],
            variants: newVariants,
          ),
        );
      }

      return Right(productVariantsResponse);
    } catch (_) {
      return Left(
        CustomError(
          header: ApiText.networkHeader,
          description: ApiText.networkDescription,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, List<PropertyEntity>>> getProperties(
      {required String productId}) async {
    try {
      final Response dataSourceResponse =
          await _dataSource.getProperties(productId: productId);
      if (dataSourceResponse.statusCode == 200) {
        final List<PropertyEntity> propertyList =
            (dataSourceResponse.data['items'] as List)
                .map<PropertyEntity>(
                  (mapJson) => PropertyModel.fromMapJson(mapJson),
                )
                .toList();

        return Right(propertyList);
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
          description: ApiText.uknownDescription,
        ),
      );
    }
  }
}
