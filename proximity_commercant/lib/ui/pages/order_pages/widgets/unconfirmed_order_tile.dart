import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';

class UnconfirmedOrderTile extends StatelessWidget {
  const UnconfirmedOrderTile({
    Key? key,
    required this.storeName,
    required this.orderItems,
    this.totalPrice = 0.0,
  }) : super(key: key);

  final String storeName;
  final List<OrderItem> orderItems;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(normal_100),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(normalRadius),
            border: Border.all(
                width: tiny_50, color: Theme.of(context).dividerColor)),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Material(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.all(small_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmallIconButton(
                            onPressed: () {},
                            icon: Icon(ProximityIcons.store,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(width: small_100),
                        Expanded(
                            child: Text('$storeName',
                                style: Theme.of(context).textTheme.headline4)),
                      ]))),

          const Divider(thickness: tiny_50, height: tiny_50),

          /// Order Items (Ordered Products)
          ...List.generate(orderItems.length,
                  (index) => OrderItemTile(orderItem: orderItems[index])),
          const Divider(height: tiny_50, thickness: tiny_50),
          Padding(
              padding: const EdgeInsets.all(small_100),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const SizedBox(width: huge_100 + small_100),
                Text('Total:', style: Theme.of(context).textTheme.caption),
                const Spacer(),
                Text(' € $totalPrice',
                    style: Theme.of(context).textTheme.headline3)
              ]))
        ]));
  }
}
