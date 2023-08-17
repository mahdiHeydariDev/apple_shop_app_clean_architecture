import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String color;
  final String icon;
  final String id;
  final String thumbnail;
  final String title;
  const CategoryEntity({
    required this.color,
    required this.icon,
    required this.id,
    required this.thumbnail,
    required this.title,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
