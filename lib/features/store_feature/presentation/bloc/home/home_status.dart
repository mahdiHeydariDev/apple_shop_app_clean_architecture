import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';

class HomeStatus {}

class HomeInitStatus extends HomeStatus {}

class HomeLoadingStatus extends HomeStatus {}

class HomeSuccessStatus extends HomeStatus {
  final List<BannerEntity> banners;
  HomeSuccessStatus({
    required this.banners,
  });
}

class HomeFailedStatus extends HomeStatus {
  final CustomError error;
  HomeFailedStatus({
    required this.error,
  });
}
