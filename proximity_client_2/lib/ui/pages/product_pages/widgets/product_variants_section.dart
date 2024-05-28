import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

class ProductVariantsSection extends StatefulWidget {
  const ProductVariantsSection(
      {Key? key, required this.id, required this.productVariants})
      : super(key: key);

  final String id;
  final List<ProductVariant> productVariants;

  @override
  State<ProductVariantsSection> createState() => _ProductVariantsSectionState();
}

class _ProductVariantsSectionState extends State<ProductVariantsSection> {
  String variant_haracteriscs = "";
  int selectedVariantIndex = -1;

  String getNameValue(List<dynamic> variantEntry) {
    String result = "";
    for (var entry in variantEntry) {
      String name = entry["name"];
      dynamic value = entry["value"];
      result += "$name: $value, ";
    }
    // Remove the trailing comma and space
    result = result.substring(0, result.length - 2);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double cardSize = (MediaQuery.of(context).size.width - normal_100 * 5) / 4;
    return Column(children: [
      SectionDivider(
          leadIcon: ProximityIcons.product,
          title: 'Product Variants.',
          color: Theme.of(context).primaryColor),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: normal_100, right: normal_100, left: normal_100),
            child: Text(variant_haracteriscs,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start),
          ),
          Row(
              children: List.generate(
                  (widget.productVariants.length < 4)
                      ? widget.productVariants.length
                      : 4,
                  (index) => GestureDetector(
                        onTap: () {
                          if (widget.productVariants[index].characteristics !=
                              null) {
                            setState(() {
                              variant_haracteriscs = getNameValue(widget
                                  .productVariants[index].characteristics!);
                              selectedVariantIndex = index;
                            });
                            print(variant_haracteriscs);
                          } else {
                            variant_haracteriscs = 'haracteriscs=';
                          }
                        },
                        child: Container(
                            height: cardSize,
                            width: cardSize,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(smallRadius),
                                border: Border.all(
                                    color: (selectedVariantIndex == index)
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).dividerColor,
                                    width: tiny_50)),
                            margin: (index == 0)
                                ? const EdgeInsets.only(
                                    left: normal_100, right: small_100)
                                : (index == 4)
                                    ? const EdgeInsets.only(
                                        left: small_100, right: normal_100)
                                    : const EdgeInsets.symmetric(
                                        horizontal: small_100),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.vertical(top: smallRadius),
                              child: Stack(children: [
                                (widget.productVariants[index].image! is File)
                                    ? Image.file(
                                        widget.productVariants[index].image!)
                                    : Image.network(
                                        widget.productVariants[index].image!,
                                        errorBuilder: (
                                        BuildContext context,
                                        Object error,
                                        StackTrace? stackTrace,
                                      ) {
                                        return const AspectRatio(
                                            aspectRatio: 1.0,
                                            child: SizedBox(
                                                width: large_100,
                                                height: large_100));
                                      }),
                                if (index == 3 &&
                                    widget.productVariants.length > 4)
                                  Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background
                                              .withOpacity(0.9),
                                          borderRadius: const BorderRadius.all(
                                              innerBorderRadius)),
                                      child: Text(
                                          '${widget.productVariants.length - 3} more Variants',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          textAlign: TextAlign.center))
                              ]),
                            )),
                      ))),
        ],
      )
    ]);
  }
}
