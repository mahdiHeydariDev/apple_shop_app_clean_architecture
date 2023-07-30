import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String category;
  final String description;
  final int discountPrice;
  final String id;
  final String name;
  final String popularity;
  final int price;
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
    required this.quantity,
    required this.thumbnail,
  });

  @override
  // TODO: implement props
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
