import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';

abstract class BannersRepository {
  Future<Either<CustomError, List<BannerEntity>>> getAllBanners();
}
