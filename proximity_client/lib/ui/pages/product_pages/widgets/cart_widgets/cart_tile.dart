import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/ui/pages/pages.dart';

class CartTile extends StatelessWidget {
  const CartTile({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    /// cartProvider to execute specific methods
    final cartService = Provider.of<CartService>(context);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: normal_100)
            .copyWith(bottom: normal_100),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(normalRadius),
            border: Border.all(
                width: tiny_50, color: Theme.of(context).dividerColor)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () =>
                      cartService.checkAllOrderedProducts(cart.storeId!),
                  child: Padding(
                      padding: const EdgeInsets.all(small_100),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SmallIconButton(
                                onPressed: () {},
                                icon: Icon(ProximityIcons.store,
                                    color: Theme.of(context).primaryColor)),
                            const SizedBox(width: small_100),
                            Expanded(
                                child: Text('${cart.storeName}',
                                    style:
                                        Theme.of(context).textTheme.headlineMedium)),
                            // Icon(cart.checked
                            //     ? ProximityIcons.check_filled
                            //     : ProximityIcons.check),
                          ])))),
          (() {
            return ValueListenableBuilder<Box<CartItem>>(
                valueListenable: Boxes.getCartItemsBox().listenable(),
                builder: (context, cartItemsBox, _) {
                  final cartItems = cartItemsBox.values
                      .where((item) =>
                          cart.cartItemsKeys!.contains(item.variantId))
                      .toList()
                      .cast<CartItem>();
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, i) => Dismissible(

                          /// Each Dismissible must contain a Key. Keys allow Flutter to
                          /// uniquely identify widgets.
                          key: Key(cartItems[i].variantId!),

                          /// Provide a function that tells the app
                          /// what to do after an item has been swiped away.
                          onDismissed: (direction) {
                            /// Remove the item from the data source.
                            cartService
                                .deleteItemFromCart(cartItems[i].variantId!);

                            /// Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Product Successfully deleted!')));
                          },

                          /// Show a red background as the item is swiped away.
                          background: Container(
                              color: Theme.of(context).scaffoldBackgroundColor),
                          child: CartProductTile(
                              cartItem: cartItems[i],
                              onPressed: () => cartService
                                  .checkOrderedProduct(cartItems[i].variantId!),
                              increase: () => cartService
                                  .addQuantity(cartItems[i].variantId!),
                              decrease: () => cartService
                                  .subtractQuantity(cartItems[i].variantId!))));
                });
          }()),
          const Divider(height: tiny_50, thickness: tiny_50),
          Padding(
              padding: const EdgeInsets.all(small_100),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                      text: '€ ', style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(
                      text: '${cartService.getTotalPrice(cart.storeId!)}',
                      style: Theme.of(context).textTheme.headlineMedium)
                ]))),
                PrimaryButton(
                    onPressed: cartService.valid(cart.storeId!)
                        ? () => cartService.order(context, cart.storeId!)
                        : null,
                    // onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>  CartSliderScreen()));
                    // } ,
                    title: AppLocalizations.of(context)!.order)
              ]))
        ]));
  }
}
