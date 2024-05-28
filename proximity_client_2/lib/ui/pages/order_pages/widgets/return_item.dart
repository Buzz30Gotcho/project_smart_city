
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';

class ReturnItem extends StatelessWidget {
  const ReturnItem(
      {Key? key,
      required this.product,
      required this.returnService,
      this.shrinkWidth = true,
      this.reservation})
      : super(key: key);

  final OrderItem product;
  final bool shrinkWidth;
  final ReturnScreenValidation returnService;
  final bool? reservation;

  @override
  Widget build(BuildContext context) {
    /// A [productProxy] is declared to update its value [idShop] whenever
    /// a new shop is selected
    print("item");
    print(product.image);
    SizedBox productCard = SizedBox(
        height: 130,
        width: double.infinity,
        child: Container(
            padding: const EdgeInsets.all(tiny_50),
            margin: const EdgeInsets.symmetric(
                horizontal: small_100, vertical: small_50),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(smallRadius),
                  child: Image.network((product.image ?? ""),
                      height: huge_100 - small_50,
                      width: huge_100 - small_50,
                      fit: BoxFit.contain,
                      alignment: Alignment.center, errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return const AspectRatio(
                        aspectRatio: 1.0,
                        child: SizedBox(width: large_100, height: large_100));
                  })),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(small_50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                        '${product.name!}   € ${double.parse((product.price!).toStringAsFixed(2))}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ]),
                            const Spacer(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  QuantitySelector(
                                      quantity: product.returnQuantity ?? 0,
                                      // maxQuantity: product.orderedQuantity,
                                      increaseQuantity: () => {
                                            returnService
                                                .changeReturnedItemQuantity(
                                                    (product.returnQuantity ??
                                                            0) +
                                                        1,
                                                    product.variantId)
                                          },
                                      decreaseQuantity: () => {
                                            if ((product.returnQuantity!) > 0)
                                              {
                                                returnService
                                                    .changeReturnedItemQuantity(
                                                        (product.returnQuantity ??
                                                                0) -
                                                            1,
                                                        product.variantId)
                                              }
                                          }),
                                ]),
                          ]))),
            ])));

    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(smallRadius),
            color: Color(0xFFE4E4E4)),
        margin: const EdgeInsets.symmetric(vertical: small_100),
        child: Padding(
            padding: const EdgeInsets.all(small_100),
            child: Column(children: [
              (product.discount != 0.0)
                  ? Stack(children: [
                      productCard,
                      Container(
                          padding: const EdgeInsets.all(tiny_50),
                          margin:
                              const EdgeInsets.symmetric(vertical: small_100),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(tinyRadius),
                              color: redSwatch.shade500),
                          child: Text(
                            '-${(product.discount * 100).toInt()}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: primaryTextDarkColor,
                                    fontWeight: FontWeight.w800),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ])
                  : productCard,
            ])));
  }
}
