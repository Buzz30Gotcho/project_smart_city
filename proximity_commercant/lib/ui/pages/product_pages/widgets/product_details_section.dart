import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection(
      {Key? key,
      required this.name,
      required this.price,
      this.discount = 0.0,
      this.discountEndDate})
      : super(key: key);

  final String name;
  final double price;
  final double discount;
  final DateTime? discountEndDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(small_100),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
                child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      if (discount != 0.0)
                        TextSpan(
                            text: '€ $price\n',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: small_50,
                                    decorationColor: redSwatch.shade500)),
                      TextSpan(
                          text: (discount != 0.0)
                              ? '€ ${double.parse((price * (1 - discount)).toStringAsFixed(2))}'
                              : '€ $price',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.bold))
                    ]),
                    overflow: TextOverflow.fade)),
            if (discount != 0.0)
              Container(
                  padding: const EdgeInsets.all(tiny_50),
                  margin: const EdgeInsets.symmetric(vertical: small_100),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(tinyRadius),
                      color: redSwatch.shade500),
                  child: Text(
                    '-${(discount * 100).toInt()}%',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: primaryTextDarkColor,
                        fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
          ]),
          const SizedBox(height: normal_100),
          Text(name,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start)
        ]));
  }
}
