import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/ui/pages/product_pages/widgets/widgets.dart';

class TodayDealsScreen extends StatelessWidget {
  const TodayDealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductService>(builder: (_, productService, __) {
      return Scaffold(
          body: SafeArea(
              child: ListView(children: [
        const TopBar(title: "Today's deals."),
        if (productService.promotions.isEmpty)
          const CircularProgressIndicator()
        else
          ...List.generate(productService.promotions.length, (index) {
            return SmallProductCard(
                shrinkWidth: false,
                product: productService.promotions[index].product);
          })
      ])));
    });
  }
}
