
class ProductCart {
  String? id;
  String? productId;
  String? variantId;
  String? name;
  List<Map<String, String>>? characteristics;
  String? image;
  double? price;
  int quantity;
  double discount;
  bool reservation;
  double reservationP;
  bool delivery;
  double deliveryP;
  bool pickup;
  bool reservationPolicy;
  bool deliveryPolicy;
  bool pickupPolicy;
  // Policy? policy ;

  ProductCart({
    this.id,
    this.productId,
    this.variantId,
    this.name,
    this.characteristics,
    this.image,
    this.price,
    this.quantity = 0,
    this.discount = 0.0,
    this.reservation = false,
    this.reservationP = 0.0,
    this.delivery = false,
    this.deliveryP = 0.0,
    this.pickup = false,
    this.reservationPolicy = true,
    this.deliveryPolicy = true,
    this.pickupPolicy = true,
  });
}
