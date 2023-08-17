import 'package:equatable/equatable.dart';

class GalleryImageEntity extends Equatable {
  final String imageId;
  final String imageUrl;
  const GalleryImageEntity({
    required this.imageId,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [
        imageId,
        imageUrl,
      ];
}
