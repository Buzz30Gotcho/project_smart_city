import 'package:proximity_client/domain/product_repository/models/policy_model.dart';

import 'product_variant_model.dart';
import 'package:proximity/config/backend.dart';

class Product {
  String? id;
  String? name;
  String? description;
  double? price;
  double discount;
  DateTime? discountEndDate;
  List<dynamic>? images;
  List<ProductVariant>? variants;
  String? categoryId;
  String? categoryName;
  List<dynamic>? tags;
  String? storeId;
  String? sellerId;
  Policy? policy;
  double? reservation;
  Map<String, List<String>>? characteristics;
  int? numberOfSales;
  int? numberOfSearches;
  double? averageRating;
  DateTime? releaseDate;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.discount = 0.0,
      this.discountEndDate,
      this.images,
      this.variants,
      this.categoryId,
      this.categoryName,
      this.characteristics,
      this.numberOfSales = 0,
      this.numberOfSearches = 0,
      this.averageRating = 0,
      this.releaseDate,
      this.policy,
      this.storeId,
      this.sellerId,
      this.reservation = 0.0});

  Product.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        description = parsedJson['description'],
        price = parsedJson['price'].toDouble(),
        categoryId = parsedJson['categoryId'],
        categoryName = parsedJson['category'],
        images =
            parsedJson['images'].map((el) => '$BASE_IMG_URL/' + el).toList(),
        tags = parsedJson['tags'],
        variants =
            ProductVariant.productVariantsFromJsonList(parsedJson['variants']),
        storeId = parsedJson['storeId'],
        sellerId = parsedJson['sellerId'],
        discount = parsedJson['discount'].toDouble(),
        discountEndDate = DateTime.parse(parsedJson['discountExpiration']),
        policy = parsedJson['policy'] == null
            ? null
            : Policy.fromJson(parsedJson['policy']);

  static List<Product> productsFromJsonList(List<dynamic> parsedJson) {
    List<Product> list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      list.add(Product.fromJson(parsedJson[i]));
    }
    return list;
  }

  bool allFetched() {
    return ((id != null) &&
        (name != null) &&
        (description != null) &&
        (price != null) &&
        (discountEndDate != null) &&
        (images != null) &&
        (variants != null) &&
        // (categoryName != null) &&
        (storeId != null));
  }

  double getPrice() {
    return double.parse((price! *
            (1 - discount) *
            (reservation != 0.0 ? (reservation ?? 1.0) : 1.0))
        .toStringAsFixed(2));
  }

  static List<Product> products = [];
}
