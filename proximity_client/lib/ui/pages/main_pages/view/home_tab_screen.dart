import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/ui/pages/main_pages/main_pages.dart';
//import 'package:proximity_client/ui/pages/main_pages/view/notifications_screen.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity_client/ui/pages/product_pages/product_pages.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/search_bar.dart' as proxSearch;

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductService>(builder: (_, productService, __) {
      return Scaffold(
        body: ListView(children: [
          const HomeTabBar(),
          const proxSearch.SearchBar(),

          /// Ad Section
          productService.ads.isEmpty
              ? const AdSectionSkeleton()
              : AdSection(ads: productService.ads),

          /// Today's Deals
          SectionDivider(
              leadIcon: ProximityIcons.flashdeal,
              title: AppLocalizations.of(context)!.todayDeals,
              color: yellowSwatch.shade600,
              seeMore: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TodayDealsScreen()));
              }),
          SizedBox(
              height: huge_100,
              // child: (productService.loadingdealsList == true)
              child: productService.promotions.isEmpty
                  ? const SmallProductCardsSkeleton()
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: normal_150),
                      children: List.generate(
                          productService.promotions.take(5).toList().length,
                          (i) => SmallProductCard(
                              product: productService.promotions[i].product)))),

          /// Products Around You
          SectionDivider(
              leadIcon: ProximityIcons.product,
              title: AppLocalizations.of(context)!.productsAroundYou,
              color: greenSwatch.shade300),
          (productService.loadingProductList == true)
              ? const ProductCardsSkeleton()
              : productService.products.isEmpty
                  ? Center(
                      child: InkWell(
                      onTap: () {
                        productService.getProximityProducts();
                      },
                      child: const Icon(Icons.refresh),
                    ))
                  : MasonryGrid(
                      column: 2,
                      padding:
                          const EdgeInsets.symmetric(horizontal: small_100),
                      children: List.generate(
                          productService.products.length,
                          (i) => ProductCard(
                              product: productService.products[i]))),
          const SizedBox(height: large_200)
        ]),
      );
    });
  }
}
