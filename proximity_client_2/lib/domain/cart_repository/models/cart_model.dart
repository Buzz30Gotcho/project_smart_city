import 'package:hive_flutter/hive_flutter.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject {
  @HiveField(0)
  String? storeId;
  @HiveField(1)
  String? storeName;
  @HiveField(2)
  String? storeImage;
  @HiveField(3)
  List<String>? cartItemsKeys;
  @HiveField(4)
  bool checked;
  @HiveField(5)
  Cart(
      {this.storeId,
      this.storeName,
      this.storeImage,
      this.cartItemsKeys,
      this.checked = true});
}
