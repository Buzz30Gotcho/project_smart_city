import 'package:hive/hive.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

part 'wishlist_item_model.g.dart';

@HiveType(typeId: 2)
class WishlistItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  double discount;

  @HiveField(5)
  DateTime? discountEndDate;

  @HiveField(6)
  List<dynamic> images;

  @HiveField(7)
  List<String> variantImages;

  @HiveField(8)
  String? categoryName;

  @HiveField(9)
  String storeId;

  WishlistItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.discountEndDate,
    required this.images,
    required this.variantImages,
    this.categoryName,
    required this.storeId,
  });

  WishlistItem.fromProduct(Product product)
      : id = product.id!,
        name = product.name!,
        description = product.description!,
        price = product.price!,
        discount = product.discount,
        discountEndDate = product.discountEndDate,
        images = product.images!,
        variantImages = List.generate(product.variants!.length,
            (index) => product.variants![index].image!),
        categoryName = product.categoryName,
        storeId = product.storeId!;

  Product toProduct() => Product(
      id: id,
      name: name,
      description: description,
      price: price,
      discount: discount,
      discountEndDate: discountEndDate,
      images: images,
      variants: null,
      categoryName: categoryName,
      storeId: storeId);
}
