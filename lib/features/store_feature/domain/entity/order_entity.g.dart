// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderEntityAdapter extends TypeAdapter<OrderEntity> {
  @override
  final int typeId = 1;

  @override
  OrderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      warranty: fields[2] as String,
      mainImageUrl: fields[3] as String,
      realPrice: fields[4] as int,
      discountPrice: fields[5] as int,
      finalPrice: fields[6] as int,
      count: fields[7] as int,
      productVariants: (fields[8] as List).cast<ProductVariantEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.warranty)
      ..writeByte(3)
      ..write(obj.mainImageUrl)
      ..writeByte(4)
      ..write(obj.realPrice)
      ..writeByte(5)
      ..write(obj.discountPrice)
      ..writeByte(6)
      ..write(obj.finalPrice)
      ..writeByte(7)
      ..write(obj.count)
      ..writeByte(8)
      ..write(obj.productVariants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
