import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? variantId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? variantName;

  @HiveField(4)
  String? categoryName;

  @HiveField(5)
  List<dynamic>? characteristics;

  @HiveField(6)
  String? image;

  @HiveField(7)
  double? price;

  @HiveField(8)
  int? quantity;

  @HiveField(9)
  double discount;

  @HiveField(10)
  DateTime? discountEndDate;

  @HiveField(11)
  String? storeId;

  @HiveField(12)
  int orderedQuantity;

  @HiveField(13)
  bool checked;

  CartItem({
    this.id,
    this.variantId,
    this.name,
    this.variantName,
    this.categoryName,
    this.characteristics,
    this.image,
    this.price,
    this.quantity,
    this.discount = 0.0,
    this.discountEndDate,
    this.storeId,
    this.orderedQuantity = 0,
    this.checked = false,
  });

  CartItem.fromProduct(Product product, ProductVariant productVariant,
      this.orderedQuantity, this.checked)
      : id = product.id,
        variantId = productVariant.id,
        name = product.name,
        variantName = productVariant.variantName,
        image = productVariant.image,
        price = productVariant.price,
        quantity = productVariant.quantity,
        discount = product.discount,
        discountEndDate = product.discountEndDate,
        storeId = product.storeId;

  // not used
  Product toProduct() => Product(
        id: id,
        name: name,
        price: price,
        discount: discount,
        discountEndDate: discountEndDate,
        storeId: storeId,
      );
}
