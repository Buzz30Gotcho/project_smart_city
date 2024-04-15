import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/ui/pages/product_pages/product_pages.dart';

class CartProductTile extends ProductTile {
  CartProductTile({
    Key? key,
    required CartItem cartItem,
    VoidCallback? onPressed,
    VoidCallback? increase,
    VoidCallback? decrease,
  }) : super(
            key: key,
            product: cartItem.toProduct(),
            productVariant: ProductVariant(
                id: cartItem.variantId,
                variantName: cartItem.variantName,
                characteristics: cartItem.characteristics,
                image: cartItem.image),
            // onPressed: onPressed,
            // leftChild: Icon(cartItem.checked
            //     ? Icons.check_box_rounded
            //     : Icons.check_box_outline_blank_outlined),
            // rightChild: Icon(cartItem.checked
            //     ? ProximityIcons.check_filled
            //     : ProximityIcons.check),
            bottomRightChild: QuantitySelector(
                quantity: cartItem.orderedQuantity,
                // maxQuantity: cartItem.quantity,
                increaseQuantity: increase,
                decreaseQuantity: decrease));
}
