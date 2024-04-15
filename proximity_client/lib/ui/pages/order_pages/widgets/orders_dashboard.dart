import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:provider/provider.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';

class OrdersDashboard extends StatelessWidget {
  const OrdersDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: normal_150),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(smallRadius),
          border: Border.all(
              color: Theme.of(context).dividerColor, width: tiny_50)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(innerBorderRadius),
        child: Material(
          color: Theme.of(context).cardColor,
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: small_100),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Orders',
                          style: Theme.of(context).textTheme.bodyLarge),
                      Row(children: [
                        Text('See All',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Icon(ProximityIcons.arrow_more,
                            color: Theme.of(context).textTheme.bodyMedium!.color)
                      ])
                    ])),
            SizedBox(
                height: large_200,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("all", "Pending");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 4)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DuotoneIcon(
                                        size: 25,
                                        primaryLayer:
                                            ProximityIcons.unpaid_duotone_1,
                                        secondaryLayer:
                                            ProximityIcons.unpaid_duotone_1,
                                        color: redSwatch.shade500),
                                    Text('Pending',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("pickup", "all");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 0)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DuotoneIcon(
                                        size: 25,
                                        primaryLayer: ProximityIcons
                                            .self_pickup_duotone_1,
                                        secondaryLayer: ProximityIcons
                                            .self_pickup_duotone_2,
                                        color: redSwatch.shade500),
                                    Text('Self Pickup',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("delivery", "all");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 1)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DuotoneIcon(
                                        size: 25,
                                        primaryLayer:
                                            ProximityIcons.delivery_duotone_1,
                                        secondaryLayer:
                                            ProximityIcons.delivery_duotone_2,
                                        color: redSwatch.shade500),
                                    Text('Delivery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("reservation", "all");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 3)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DuotoneIcon(
                                        size: 25,
                                        primaryLayer:
                                            ProximityIcons.history_duotone_1,
                                        secondaryLayer:
                                            ProximityIcons.history_duotone_2,
                                        color: redSwatch.shade500),
                                    Text('Reservation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("return", "all");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 5)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 2),
                                    SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Positioned.fill(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              normalRadius),
                                                      child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.asset(
                                                              "assets/img/return_icon2.png")))),
                                            ])),
                                    const SizedBox(height: 3),
                                    Text('Return',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("refund", "all");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 6)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 2),
                                    SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Positioned.fill(
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              normalRadius),
                                                      child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.asset(
                                                              "assets/img/refund_icon.png")))),
                                            ])),
                                    const SizedBox(height: 3),
                                    Text('Refund',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ]))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                ordersService.getOrders("all", "Canceled");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersScreen(page: 2)));
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DuotoneIcon(
                                        size: 25,
                                        primaryLayer:
                                            ProximityIcons.rejected_duotone_1,
                                        secondaryLayer:
                                            ProximityIcons.rejected_duotone_2,
                                        color: redSwatch.shade500),
                                    Text('Rejected',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(height: 0.9, fontSize: 7))
                                  ])))
                    ]))
          ]),
        ),
      ),
    );
  }
}
