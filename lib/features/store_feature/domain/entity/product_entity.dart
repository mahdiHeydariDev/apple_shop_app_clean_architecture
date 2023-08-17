import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String category;
  final String description;
  final int discountPrice;
  final String id;
  final String name;
  final String popularity;
  final int price;
  final num realPrice;
  final num percent;
  final int quantity;
  final String thumbnail;
  const ProductEntity({
    required this.category,
    required this.description,
    required this.discountPrice,
    required this.id,
    required this.name,
    required this.popularity,
    required this.price,
    required this.realPrice,
    required this.percent,
    required this.quantity,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [
        category,
        description,
        discountPrice,
        id,
        name,
        popularity,
        price,
        quantity,
        thumbnail,
      ];
}
