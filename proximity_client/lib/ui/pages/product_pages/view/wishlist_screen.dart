import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/ui/pages/product_pages/product_pages.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userSettings = Provider.of<UserSettings>(context);
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      const TopBar(title: 'Wishlist.'),
      Consumer<WishlistService>(
          builder: (_, wishlistService, __) =>
              ValueListenableBuilder<Box<WishlistItem>>(
                  valueListenable: Boxes.getWishlist().listenable(),
                  builder: (_, wishlistBox, __) {
                    final wishlist =
                        wishlistBox.values.toList().cast<WishlistItem>();

                    return wishlist.isEmpty
                        ? const NoResults(
                            icon: ProximityIcons.empty_illustration,
                            message:
                                'Your Wishlist is empty, consider liking products.')
                        : MasonryGrid(
                            column: 2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: small_100),
                            children: List.generate(
                                wishlistService.wishlistBox.length,
                                (i) => ProductCard(
                                    product: wishlist[i].toProduct())));
                  }))
    ])));
  }
}
