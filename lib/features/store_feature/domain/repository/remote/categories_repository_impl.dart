import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/category_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/category_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/categories_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoryDataSource _dataSource;
  CategoriesRepositoryImpl(this._dataSource);
  @override
  Future<Either<CustomError, List<CategoryEntity>>> getAllCategories() async {
    try {
      final Response datasourceResponse = await _dataSource.getAllCategories();
      if (datasourceResponse.statusCode == 200) {
        final List<CategoryEntity> bannersList =
            (datasourceResponse.data['items'] as List)
                .map<CategoryEntity>(
                  (mapJson) => CategoryModel.fromMapJson(mapJson),
                )
                .toList();

        return Right(bannersList);
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

  @override
  Future<Either<CustomError, CategoryEntity>> getCategoryById(
      {required String id}) async {
    try {
      final Response datasourceResponse =
          await _dataSource.getCategoryById(id: id);

      if (datasourceResponse.statusCode == 200) {
        final CategoryEntity category =
            CategoryModel.fromMapJson(datasourceResponse.data['items'][0]);

        return Right(category);
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
