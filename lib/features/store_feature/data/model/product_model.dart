import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.category,
    required super.description,
    required super.discountPrice,
    required super.id,
    required super.name,
    required super.popularity,
    required super.price,
    required super.realPrice,
    required super.percent,
    required super.quantity,
    required super.thumbnail,
  });
  factory ProductModel.fromMapJson(Map<String, dynamic> mapJson) {
    return ProductModel(
      category: mapJson['category'],
      description: mapJson['description'],
      discountPrice: mapJson['discount_price'],
      id: mapJson['id'],
      name: mapJson['name'],
      popularity: mapJson['popularity'],
      price: mapJson['price'],
      realPrice: mapJson['price'] + mapJson['discount_price'],
      percent: calcutePercent(
        realPrice: mapJson['price'],
        discountPrice: mapJson['discount_price'],
      ),
      quantity: mapJson['quantity'],
      thumbnail:
          'http://startflutter.ir/api/files/${mapJson['collectionId']}/${mapJson['id']}/${mapJson['thumbnail']}',
    );
  }
}

num calcutePercent({required realPrice, required discountPrice}) {
  return ((-(discountPrice) / realPrice) * 100).round();
}
