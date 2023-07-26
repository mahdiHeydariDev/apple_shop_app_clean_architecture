import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_status.dart';

class HomeState {
  final HomeStatus status;
  HomeState({required this.status});
  HomeState setStatus(HomeStatus newStatus) {
    return HomeState(status: newStatus != status ? newStatus : status);
  }
}
