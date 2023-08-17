import 'package:equatable/equatable.dart';

class VariantEntity extends Equatable {
  final String id;
  final String name;
  final int priceChange;
  final String productId;
  final String typeId;
  final String value;
  const VariantEntity({
    required this.id,
    required this.name,
    required this.priceChange,
    required this.productId,
    required this.typeId,
    required this.value,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        priceChange,
        productId,
        typeId,
        value,
      ];
}
