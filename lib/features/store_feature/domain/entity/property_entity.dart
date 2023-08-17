import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final String id;
  final String productId;
  final String title;
  final String value;
  const PropertyEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.value,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        value,
      ];
}
