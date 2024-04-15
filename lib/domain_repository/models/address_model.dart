class Address {
  double? lat;
  double? lng;
  String? city;
  String? fullAddress;
  String? streetName;
  String? postalCode;
  String? countryCode;
  String? countryName;
  String? locality;
  String? region;

  String get getAddressLine => '$fullAddress, $streetName, $city, $countryName';

  void changeLatLng(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  void changeCity(String value) {
    city = value;
  }

  bool get isAddressValid {
    if ((fullAddress != null) &&
        (streetName != null) &&
        (lat != null) &&
        (lng != null) &&
        (city != null) &&
        (postalCode != null) &&
        (countryCode != null) &&
        (countryName != null) &&
        (locality != null) &&
        (region != null)) {
      return true;
    } else {
      return false;
    }
  }

  Address({
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
}
