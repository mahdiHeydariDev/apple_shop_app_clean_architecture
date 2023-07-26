import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String? categoryId;
  final String? thumbnail;
  const BannerEntity({
    required this.categoryId,
    required this.thumbnail,
  });
  @override
  List<Object?> get props => [
        categoryId,
        thumbnail,
      ];
}
