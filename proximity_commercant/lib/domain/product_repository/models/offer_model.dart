import 'package:flutter/foundation.dart';

class Offer {
  String? id;
  String? productId;
  int? offerDiscount;
  int? offerStock;
  final DateTime? offerExpiration;
  String? offerStatus;
  bool? offerDeleted;
  //final String offerName;
  //final String offerImage;
  //final String offerDescription;
  String? discountType;

  Offer({
    this.id,
    this.offerDiscount,
    this.offerStock,
    this.offerExpiration,
    this.offerStatus,
    this.offerDeleted,
    this.productId,
    /* @required this.offerName,
    @required this.offerImage,
    @required this.offerDescription,*/
    @required this.discountType,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    print('ox' + DateTime.parse(json['offerExpiration']).toString());
    return Offer(
      id: json['_id'],
      offerDiscount: (json['offerDiscount'].toDouble() * 100).toInt(),
      offerStock: json['offerStock'],
      offerDeleted: json['offerDeleted'],
      discountType: json['discountType'],

      offerExpiration: DateTime.parse(json['offerExpiration']),
      offerStatus: json['offerStatus'],

      // offerName: json['offerName'],
      //  offerImage: json['offerImage'],
      //offerDescription: json['offerDescription'],*/
    );
  }
  static List<Offer> productsFromJsonList(List<dynamic> parsedJson) {
    List<Offer> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(Offer.fromJson(parsedJson[i]));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    return {
      /*  '_id': id,
      'sellerId': sellerId,
      'storeId': storeId,
      'productId': productId,*/
      'offerDiscount': offerDiscount,
      'offerStock': offerStock,
      //'offerExpiration': offerExpiration.toIso8601String(),
      //'offerStatus': offerStatus,
      'offerDeleted': offerDeleted,
      /*'offerName': offerName,
      'offerImage': offerImage,
      'offerDescription': offerDescription,*/
      'discountType': discountType,
    };
  }
}
