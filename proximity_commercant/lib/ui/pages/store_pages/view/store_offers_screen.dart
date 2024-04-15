import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/icons/proximity_icons.dart';
import 'package:proximity/widgets/forms/section_divider.dart';
import 'package:proximity/widgets/masonry_grid.dart';
import 'package:proximity/widgets/top_bar.dart';
import 'package:proximity_commercant/domain/product_repository/models/models.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/domain/store_repository/src/store_service.dart';
import 'package:proximity_commercant/ui/pages/product_pages/widgets/offer_item.dart';

class StoreOffersScreen extends StatefulWidget {
  String? storeId;
  StoreOffersScreen({Key? key, this.storeId}) : super(key: key);

  @override
  State<StoreOffersScreen> createState() => _StoreOffersScreenState();
}

class _StoreOffersScreenState extends State<StoreOffersScreen> {
  /// a boolean to help fetch data ONLY if necessary
  bool didFetch = false;
  String? storeId = "";

  @override
  void initState() {
    super.initState();
    storeId = widget.storeId;
  }

  @override
  Widget build(BuildContext context) {
    final storeService = Provider.of<StoreService>(context);
    if (!didFetch) {
      storeService.getStoreOffers(storeId!);
      setState(() {
        didFetch = true;
      });
    }

    return Consumer<StoreService>(builder: (context, storeService, child) {
      return Scaffold(
          body: SafeArea(
              child: ListView(children: [
        const TopBar(title: 'Discounts.'),
        if (storeService.storeOffers == null)
          const Center(child: CircularProgressIndicator())
        else
          MasonryGrid(
              padding: EdgeInsets.symmetric(
                  vertical: normal_100, horizontal: small_100),
              column: 1,
              children: [
                SectionDivider(
                    leadIcon: Icons.discount_outlined,
                    title: 'Archived Discounts',
                    color: Theme.of(context).primaryColor),
                ...List.generate(
                    storeService.storeOffers!
                        .where((element) => !element!.offerDeleted!)
                        .length!,
                    (index) => OfferItem(
                          offer: storeService.storeOffers!
                              .where((element) => !element.offerDeleted!)
                              .toList()[index],
                        )),
                SectionDivider(
                    leadIcon: Icons.discount_outlined,
                    title: 'Archived Discounts.',
                    color: Theme.of(context).primaryColor),
                ...List.generate(
                    storeService.storeOffers!
                        .where((element) => element!.offerDeleted!)
                        .length!,
                    (index) => OfferItem(
                          offer: storeService.storeOffers!
                              .where((element) => element.offerDeleted!)
                              .toList()[index],
                        )),
              ])
      ])));
    });
  }
}
