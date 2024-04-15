import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';
import 'package:proximity_client/ui/pages/product_pages/product_pages.dart';

class SmallProductCard extends StatelessWidget {
  const SmallProductCard(
      {Key? key, required this.product, this.shrinkWidth = true})
      : super(key: key);

  final Product product;
  final bool shrinkWidth;

  @override
  Widget build(BuildContext context) {
    /// A [productProxy] is declared to update its value [idShop] whenever
    /// a new shop is selected
    final storeProxy = Provider.of<StoreProxy>(context);

    SizedBox productCard = SizedBox(
        height: huge_100,
        width: shrinkWidth ? huge_300 : null,
        child: CardButton(
            onPressed: () {
              storeProxy.idStore = product.storeId!;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(id: product.id!)));
            },
            margin: const EdgeInsets.symmetric(horizontal: small_100),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: smallRadius),
                  child: (product.images!.first is File)
                      ? Image.file(product.images!.first,
                          height: huge_100 - small_50,
                          width: huge_100 - small_50,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter)
                      : Image.network(product.images!.first,
                          height: huge_100 - small_50,
                          width: huge_100 - small_50,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter, errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return const AspectRatio(
                              aspectRatio: 1.0,
                              child: SizedBox(
                                  width: large_100, height: large_100));
                        })),
              const VerticalDivider(width: tiny_50, thickness: tiny_50),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(small_50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(product.name!,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            const Spacer(),
                            if (product.discount != 0.0)
                              Text('€ ${product.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: small_50,
                                          decorationColor: redSwatch.shade500)),
                            Text(
                              (product.discount != 0.0)
                                  ? '€ ${double.parse((product.price! * (1 - product.discount)).toStringAsFixed(2))}'
                                  : '€ ${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            )
                          ])))
            ])));

    return Padding(
        padding:
            shrinkWidth ? EdgeInsets.zero : const EdgeInsets.all(small_100),
        child: (product.discount != 0.0)
            ? Stack(children: [
                productCard,
                Container(
                    padding: const EdgeInsets.all(tiny_50),
                    margin: const EdgeInsets.symmetric(vertical: small_100),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(tinyRadius),
                        color: redSwatch.shade500),
                    child: Text(
                      '-${(product.discount * 100).toInt()}%',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: primaryTextDarkColor,
                          fontWeight: FontWeight.w800),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))
              ])
            : productCard);
  }
}
