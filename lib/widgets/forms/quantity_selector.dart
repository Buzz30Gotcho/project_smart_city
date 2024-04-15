import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector(
      {Key? key,
      required this.quantity,
      this.maxQuantity = MAX_ORDER_QUANTITY,
      this.increaseQuantity,
      this.decreaseQuantity})
      : super(key: key);

  final int quantity;
  final int? maxQuantity;
  final VoidCallback? increaseQuantity;
  final VoidCallback? decreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallIconButton(
            onPressed: (quantity != 0) ? decreaseQuantity : null,
            icon: const Icon(ProximityIcons.subtract)),
        const SizedBox(width: small_100),
        Text('$quantity',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Theme.of(context).primaryColor)),
        const SizedBox(width: small_100),
        SmallIconButton(
            onPressed: (quantity <= maxQuantity!) ? increaseQuantity : null,
            icon: const Icon(ProximityIcons.add)),
      ],
    );
  }
}
