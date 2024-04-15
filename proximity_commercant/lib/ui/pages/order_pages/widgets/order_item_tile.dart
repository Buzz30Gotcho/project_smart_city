import 'package:flutter/material.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/domain/product_repository/models/models.dart';
import 'package:proximity_commercant/ui/pages/product_pages/product_pages.dart';

class OrderItemTile extends ProductTile {
  OrderItemTile({
    Key? key,
    required OrderItem orderItem,
    bool? returnedItem,
  }) : super(
            key: key,
            product: orderItem.toProduct(),
            productVariant: ProductVariant(
                id: orderItem.variantId,
                variantName: orderItem.name,
                characteristics: [],
                image: orderItem.image,
                discount: orderItem.discount,
                reservation: orderItem.reservation),
            bottomRightChild: Text(
                'x${returnedItem == true ? orderItem.returnQuantity : orderItem.orderedQuantity}'));
}
