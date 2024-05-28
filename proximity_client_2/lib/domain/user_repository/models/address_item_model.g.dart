// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressItemAdapter extends TypeAdapter<AddressItem> {
  @override
  final int typeId = 5;

  @override
  AddressItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressItem(
      lat: fields[0] as double?,
      lng: fields[1] as double?,
      streetName: fields[2] as String?,
      city: fields[3] as String?,
      postalCode: fields[4] as String?,
      countryCode: fields[5] as String?,
      countryName: fields[6] as String?,
      fullAddress: fields[7] as String?,
      locality: fields[8] as String?,
      region: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.fullAddress)
      ..writeByte(4)
      ..write(obj.streetName)
      ..writeByte(5)
      ..write(obj.postalCode)
      ..writeByte(6)
      ..write(obj.countryCode)
      ..writeByte(7)
      ..write(obj.countryName)
      ..writeByte(8)
      ..write(obj.locality)
      ..writeByte(9)
      ..write(obj.region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
