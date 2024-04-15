// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistItemAdapter extends TypeAdapter<WishlistItem> {
  @override
  final int typeId = 2;

  @override
  WishlistItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistItem(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      discount: fields[4] as double,
      discountEndDate: fields[5] as DateTime?,
      images: (fields[6] as List).cast<dynamic>(),
      variantImages: (fields[7] as List).cast<String>(),
      categoryName: fields[8] as String?,
      storeId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.discountEndDate)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.variantImages)
      ..writeByte(8)
      ..write(obj.categoryName)
      ..writeByte(9)
      ..write(obj.storeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
