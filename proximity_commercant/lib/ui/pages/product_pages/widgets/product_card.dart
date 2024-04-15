import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/ui/pages/product_pages/product_pages.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    CardButton _productCard = CardButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(id: widget.product.id!)));
        },
        margin: const EdgeInsets.symmetric(horizontal: small_100)
            .copyWith(bottom: normal_100),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: smallRadius),
                  child: (widget.product.images!.first is File)
                      ? Image.file(widget.product.images!.first)
                      : Image.network(widget.product.images!.first,
                          errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return const AspectRatio(
                              aspectRatio: 1.0,
                              child: SizedBox(
                                  width: large_100, height: large_100));
                        })),
              const Divider(height: tiny_50, thickness: tiny_50),
              Padding(
                  padding: const EdgeInsets.all(small_50 + tiny_50),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(widget.product.name!,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: small_50),
                        RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(children: [
                              if (widget.product.discount != 0)
                                TextSpan(
                                    text: '€ ${widget.product.price}\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: small_50,
                                            decorationColor:
                                                redSwatch.shade500)),
                              TextSpan(
                                  text: (widget.product.discount != 0)
                                      ? '€ ${double.parse((widget.product.price! * (1 - widget.product.discount)).toStringAsFixed(2))}'
                                      : '€ ${widget.product.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.bold))
                            ]),
                            overflow: TextOverflow.fade)
                      ]))
            ]));

    return _productCard;
  }
}

class ProductCardDiscount extends StatefulWidget {
  const ProductCardDiscount({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  _ProductCardDiscountState createState() => _ProductCardDiscountState();
}

class _ProductCardDiscountState extends State<ProductCardDiscount> {
  @override
  Widget build(BuildContext context) {
    CardButton _productCard = CardButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(id: widget.product.id!)));
        },
        margin: const EdgeInsets.symmetric(horizontal: small_100)
            .copyWith(bottom: normal_100),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: smallRadius),
                  child: (widget.product.images!.first is File)
                      ? Image.file(widget.product.images!.first)
                      : Image.network(widget.product.images!.first,
                          errorBuilder: (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return const AspectRatio(
                              aspectRatio: 1.0,
                              child: SizedBox(
                                  width: large_100, height: large_100));
                        })),
              const Divider(height: tiny_50, thickness: tiny_50),
              Padding(
                  padding: const EdgeInsets.all(small_50 + tiny_50),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(widget.product.name!,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: small_50),
                        RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(children: [
                              if (widget.product.discount != 0)
                                TextSpan(
                                    text: '€ ${widget.product.price}\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: small_50,
                                            decorationColor:
                                                redSwatch.shade500)),
                              TextSpan(
                                  text: (widget.product.discount != 0)
                                      ? '€ ${double.parse((widget.product.price! * (1 - widget.product.discount)).toStringAsFixed(2))}'
                                      : '€ ${widget.product.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontWeight: FontWeight.bold))
                            ]),
                            overflow: TextOverflow.fade)
                      ]))
            ]));

    return (widget.product.discount != 0)
        ? Stack(children: [
            _productCard,
            Container(
                padding: const EdgeInsets.all(tiny_50),
                margin: const EdgeInsets.symmetric(vertical: small_100),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(tinyRadius),
                    color: redSwatch.shade500),
                child: Text('-${(widget.product.discount * 100).toInt()}%',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: primaryTextDarkColor,
                        fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))
          ])
        : _productCard;
  }
}
