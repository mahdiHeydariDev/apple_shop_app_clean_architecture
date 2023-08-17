import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/banners_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/banner_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/banners_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';

class BannersRepositoryImpl extends BannersRepository {
  final BannersDataSource _dataSource;
  BannersRepositoryImpl(this._dataSource);
  @override
  Future<Either<CustomError, List<BannerEntity>>> getAllBanners() async {
    try {
      final Response responseDataSource = await _dataSource.getAllBanners();

      if (responseDataSource.statusCode == 200) {
        final List<BannerModel> bannersList =
            (responseDataSource.data['items'] as List)
                .map<BannerModel>(
                  (element) => BannerModel.fromMapJson(element),
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
          description: ApiText.uknownDescription,
        ),
      );
    }
  }
}
