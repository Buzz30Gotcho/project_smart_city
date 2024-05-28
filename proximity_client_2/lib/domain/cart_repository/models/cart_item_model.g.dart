// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 0;

  @override
  CartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItem(
      id: fields[0] as String?,
      variantId: fields[1] as String?,
      name: fields[2] as String?,
      variantName: fields[3] as String?,
      categoryName: fields[4] as String?,
      characteristics: (fields[5] as List?)?.cast<dynamic>(),
      image: fields[6] as String?,
      price: fields[7] as double?,
      discount: fields[8] as double,
      discountEndDate: fields[9] as DateTime?,
      storeId: fields[10] as String?,
      orderedQuantity: fields[11] as int,
      checked: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.variantId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.variantName)
      ..writeByte(4)
      ..write(obj.categoryName)
      ..writeByte(5)
      ..write(obj.characteristics)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(9)
      ..write(obj.discountEndDate)
      ..writeByte(10)
      ..write(obj.storeId)
      ..writeByte(11)
      ..write(obj.orderedQuantity)
      ..writeByte(12)
      ..write(obj.checked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
