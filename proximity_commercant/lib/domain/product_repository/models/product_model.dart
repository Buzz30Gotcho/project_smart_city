import 'package:proximity_commercant/domain/store_repository/models/models.dart';

import 'product_variant_model.dart';
import 'package:proximity/config/backend.dart';

class Product {
  String? id;
  String? name;
  String? description;
  double? price;
  int? quantity;
  double discount;
  DateTime? discountEndDate;
  List<dynamic>? images;
  List<ProductVariant>? variants;
  String? storeCategoryId;
  String? categoryId;
  String? subCategoryId;
  String? rayonId;
  String? categoryName;
  List<dynamic>? tags;
  String? storeId;
  String? offer_id;
  Policy? policy;
  double? reservation;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.quantity,
      this.discount = 0.0,
      this.discountEndDate,
      this.images,
      this.variants,
      this.storeCategoryId,
      this.categoryId,
      this.subCategoryId,
      this.rayonId,
      this.categoryName,
      this.policy,
      this.storeId,
      this.offer_id,
      this.reservation = 0.0});

  Product.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        name = parsedJson['name'],
        description = parsedJson['description'],
        price = parsedJson['price'].toDouble(),
        quantity = parsedJson['quantity'],
        storeCategoryId = parsedJson['storeCategoryId'],
        categoryId = parsedJson['categoryId'],
        subCategoryId = parsedJson['subCategoryId'],
        rayonId = parsedJson['rayonId'],
        images =
            parsedJson['images'].map((el) => BASE_IMG_URL + '/' + el).toList(),
        tags = parsedJson['tags'],
        variants =
            ProductVariant.productVariantsFromJsonList(parsedJson['variants']),
        storeId = parsedJson['storeId'],
        discount = parsedJson['discount'] != null
            ? parsedJson['discount'].toDouble()
            : 0.0,
        discountEndDate = DateTime.parse(parsedJson['discountExpiration']),
        offer_id = parsedJson['offer'],
        policy = parsedJson['policy'] == null
            ? null
            : Policy.fromJson(parsedJson['policy']);

  static List<Product> productsFromJsonList(List<dynamic> parsedJson) {
    List<Product> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(Product.fromJson(parsedJson[i]));
    }
    return _list;
  }

  bool allFetched() {
    return ((id != null) &&
        (name != null) &&
        (description != null) &&
        (price != null) &&
        (discountEndDate != null) &&
        (images != null) &&
        (variants != null) &&
        (categoryName != null) &&
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
