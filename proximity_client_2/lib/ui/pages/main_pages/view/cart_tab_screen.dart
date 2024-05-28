import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/ui/pages/pages.dart';
import 'package:flutter/scheduler.dart';

class CartTabScreen extends StatelessWidget {
  const CartTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey loadingKay = GlobalKey();
    final localizations = AppLocalizations.of(context);

    return Consumer<CartService>(builder: (context, cartService, child) {
      if (cartService.loadingOrder) {
        SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(child: LoadingPreOrderItems(key: loadingKay));
              },
            ));
      }
      return Column(
        children: [
          const SizedBox(height: large_100),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: normal_100),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const SizedBox(width: normal_100),
                Expanded(
                    child: Text(localizations!.cart,
                        style: Theme.of(context).textTheme.titleMedium)),
                SmallIconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishlistScreen()));
                    },
                    icon: Row(children: [
                      const SizedBox(width: small_100),
                      Icon(ProximityIcons.heart_filled,
                          color: redSwatch.shade500),
                      const SizedBox(width: small_50),
                      Text(localizations.wishlist,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .fontSize)),
                      const SizedBox(width: small_100)
                    ])),
                const SizedBox(width: normal_100)
              ])),
          Expanded(
              child: ValueListenableBuilder<Box<Cart>>(
                  valueListenable: Boxes.getCartBox().listenable(),
                  builder: (context, cartBox, _) {
                    final cart = cartBox.values.toList().cast<Cart>();
                    return (cart.isEmpty)
                        ? NoResults(
                            icon: ProximityIcons.empty_illustration,
                            message: localizations.emptyCartCaption)
                        : ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, i) => Dismissible(

                                /// Each Dismissible must contain a Key. Keys allow Flutter to
                                /// uniquely identify widgets.
                                key: Key(cart[i].storeId!),

                                /// Provide a function that tells the app
                                /// what to do after an item has been swiped away.
                                onDismissed: (direction) {
                                  /// Remove the item from the data source.
                                  cartService
                                      .deleteOrderFromCart(cart[i].storeId!);

                                  /// Then show a snackbar.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Order Deleted Successfully')));
                                },

                                /// Show a red background as the item is swiped away.
                                background: Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                child: CartTile(cart: cart[i])));
                  })),
          const SizedBox(height: large_200)
        ],
      );
    });
  }
}

class LoadingPreOrderItems extends StatelessWidget {
  const LoadingPreOrderItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(builder: (context, cartService, child) {
      if (!cartService.loadingOrder) {
        Navigator.pop(context);
      }
      return const Padding(
          padding: EdgeInsets.all(normal_100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF136DA5)),
              SizedBox(width: 16.0),
              Text("Loading...",
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            ],
          ));
    });
  }
}
