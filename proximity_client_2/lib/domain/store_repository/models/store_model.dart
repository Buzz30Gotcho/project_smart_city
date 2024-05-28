import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/store_repository/models/store_category.dart';
import 'package:proximity_client/domain/store_repository/models/workingTime_model.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';

class Store {
  String? id;
  String? name;
  String? description;
  double? rating;
  String? phoneNumber;
  String? ownerPhoneNumber;
  String? image;
  Address? address;
  Policy? policy;
  List<StoreCategory>? categories;
  bool? isActive;
  DateTime? creationDate;
  WorkingTime? workingTime;
  

  // List<Offer>? offers;
  // List<Flashdeal>? flashdeals;
  List<dynamic>? followers;

  Store(
      {this.id,
      this.name,
      this.description,
      this.rating,
      this.phoneNumber,
      this.ownerPhoneNumber,
      this.image,
      this.address,
      this.policy,
      this.categories,
      this.followers,
      this.creationDate,
      this.isActive,
      this.workingTime,
      });

  Store.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        description = parsedJson['description'],
        rating = (parsedJson['ratingSum'] ?? 0.0).toDouble(),
        phoneNumber = '0745431397',
        ownerPhoneNumber = '0745431397',
        image = parsedJson['image'] != null
            ? '$BASE_IMG_URL/' + parsedJson['image']
            : null,
        followers = parsedJson['followers'],
        isActive = parsedJson['isActive'],
        creationDate = parsedJson['createdAt'] != null
            ? DateTime.tryParse(parsedJson['createdAt'])
            : null,
        policy = parsedJson['policy'] == null
            ? null
            : Policy.fromJson(parsedJson['policy']),
        /* policy = Policy(
            shippingMethods: [
              if (parsedJson['policies']['delivery'] ?? false)
                ShippingMethod.delivery,
              if (parsedJson['policies']['selfPickUp'] == "total")
                ShippingMethod.selfPickupTotal
              else if (parsedJson['policies']['selfPickUp'] == "partial")
                ShippingMethod.selfPickupPartial
              else if (parsedJson['policies']['selfPickUp'] == "free")
                ShippingMethod.selfPickupFree
            ],
            tax: (parsedJson['policies']['tax'] ?? 0.0).toDouble(),
            selfPickUpPrice: (parsedJson['policies']['selfPickUp'] == "free")
                ? 0.0
                : (parsedJson['policies']['selfPickUpPrice'] ?? 0.0).toDouble(),
            openWeekend: parsedJson['policies']['openWeekend'] ?? false,
            openNight: parsedJson['policies']['openNight'] ?? false,
            openDay: parsedJson['policies']['openDay'] ?? false,
            openTime: parsedJson['policies']['openTime'] ?? false,
            closeTime: parsedJson['policies']['closeTime'] ?? false),*/
        address = Address(
          lat: (parsedJson['location']['coordinates'][1] ?? 0).toDouble(),
          lng: (parsedJson['location']['coordinates'][0] ?? 0).toDouble(),
          city: parsedJson['address']['city'],
          streetName: parsedJson['address']['streetName'],
          postalCode: parsedJson['address']['postalCode'],
          countryCode: parsedJson['address']['countryCode'],
          countryName: parsedJson['address']['country'],
          fullAddress: parsedJson['address']['fullAdress'],
          locality: parsedJson['address']['region'],
          region: parsedJson['address']['region'],
        ),
        workingTime = parsedJson['workingTime'] == null
            ? null
            : WorkingTime.fromJson(parsedJson['workingTime']),
        categories = null;

  static List<Store> storesFromJsonList(List<dynamic> parsedJson) {
    List<Store> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      list.add(Store.fromJson(parsedJson[i]));
    }
    return list;
  }

  bool allFetched() {
    return ((id != null) &&
        (name != null) &&
        (description != null) &&
        (rating != null) &&
        (image != null) &&
        (address != null) &&
        (policy != null));
  }

  bool isNew() {
    if (creationDate == null) {
      // Handle the case when createdAt is not available
      return false; // Or handle it according to your requirements
    }

    final currentDate = DateTime.now();
    final duration = currentDate.difference(creationDate!).inDays;
    return duration <= 30; // Change the duration as needed (e.g., 30 days)
  }

  static List<Store> stores = [];
}
