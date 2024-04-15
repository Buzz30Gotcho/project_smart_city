import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class ProductVariantCard extends StatelessWidget {
  const ProductVariantCard(
      {Key? key, required this.selected, this.image, this.onChanged})
      : super(key: key);

  final bool selected;
  final String? image;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final double cardSize =
        (MediaQuery.of(context).size.width - normal_100 * 5) / 4;
    return InkWell(
      onTap: onChanged,
      child: Container(
          height: cardSize,
          width: cardSize,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(smallRadius),
              border: Border.all(
                  color: selected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).dividerColor,
                  width: tiny_50),
              image: DecorationImage(image: NetworkImage('$image')))),
    );
  }
}
