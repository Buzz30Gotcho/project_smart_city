import 'package:proximity/proximity.dart';
import 'package:hive/hive.dart';

part 'address_item_model.g.dart';

@HiveType(typeId: 5)
class AddressItem extends HiveObject {
  @HiveField(0)
  double? lat;

  @HiveField(1)
  double? lng;

  @HiveField(2)
  String? city;

  @HiveField(3)
  String? fullAddress;

  @HiveField(4)
  String? streetName;

  @HiveField(5)
  String? postalCode;

  @HiveField(6)
  String? countryCode;

  @HiveField(7)
  String? countryName;

  @HiveField(8)
  String? locality;
  @HiveField(9)
  String? region;

  AddressItem({
    this.lat,
    this.lng,
    this.streetName,
    this.city,
    this.postalCode,
    this.countryCode,
    this.countryName,
    this.fullAddress,
    this.locality,
    this.region,
  });

  AddressItem.fromAdress(
    Address address,
  )   : lat = address.lat,
        lng = address.lng,
        streetName = address.streetName,
        city = address.city,
        postalCode = address.postalCode,
        countryCode = address.countryCode,
        countryName = address.countryName,
        fullAddress = address.fullAddress,
        locality = address.locality,
        region = address.region;
}
        
/*
  // not used
  Product toProduct() => Product(
        id: id,
        name: name,
        price: price,
        discount: discount,
        discountEndDate: discountEndDate,
        storeId: storeId,
      );*/

