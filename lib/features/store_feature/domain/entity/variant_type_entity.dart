import 'package:equatable/equatable.dart';

class VariantTypeEntity extends Equatable {
  final String id;
  final String name;
  final String title;
  final String type;
  const VariantTypeEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        title,
        type,
      ];
}
