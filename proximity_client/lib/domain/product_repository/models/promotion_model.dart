import 'dart:math';

import 'package:proximity_client/domain/product_repository/models/product_model.dart';

class Promotion {
  Product product;
  double? score;

  Promotion({
    required this.product,
    this.score,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    var rng = Random();
    return Promotion(
        product: Product.fromJson(json), score: rng.nextDouble() * 10);
    // json['score']?.toDouble(), // Convert the score to double if it exis;ts
  }
  static List<Promotion> productsFromJsonList(List<dynamic> parsedJson) {
    List<Promotion> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      list.add(Promotion.fromJson(parsedJson[i]));
    }
    return list;
  }
}
