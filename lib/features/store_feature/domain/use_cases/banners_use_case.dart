import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/banners_repository_impl.dart';

class BannersUseCase {
  final BannersRepositoryImpl repository;
  BannersUseCase({required this.repository});
  Future<Either<CustomError, List<BannerEntity>>> call() async {
    return await repository.getAllBanners();
  }
}
