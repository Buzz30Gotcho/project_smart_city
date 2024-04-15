import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class OrdersDashboard extends StatelessWidget {
  const OrdersDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    final localizations = AppLocalizations.of(context);
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
                child: SizedBox(
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
                                                const OrdersScreen(page: 0)));
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DuotoneIcon(
                                            size: 25,
                                            primaryLayer:
                                                ProximityIcons.unpaid_duotone_1,
                                            secondaryLayer:
                                                ProximityIcons.unpaid_duotone_1,
                                            color: redSwatch.shade500),
                                        Text(localizations!.pending,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
                                      ]))),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    ordersService.getOrders("pickup", "all");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrdersScreen(page: 1)));
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DuotoneIcon(
                                            size: 25,
                                            primaryLayer: ProximityIcons
                                                .self_pickup_duotone_1,
                                            secondaryLayer: ProximityIcons
                                                .self_pickup_duotone_2,
                                            color: redSwatch.shade500),
                                        Text(localizations.selfPickup,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
                                      ]))),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    ordersService.getOrders("delivery", "all");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrdersScreen(page: 2)));
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DuotoneIcon(
                                            size: 25,
                                            primaryLayer: ProximityIcons
                                                .delivery_duotone_1,
                                            secondaryLayer: ProximityIcons
                                                .delivery_duotone_2,
                                            color: redSwatch.shade500),
                                        Text(localizations.delivery,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
                                      ]))),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    ordersService.getOrders(
                                        "reesrvation", "all");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrdersScreen(page: 3)));
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DuotoneIcon(
                                            size: 25,
                                            primaryLayer: ProximityIcons
                                                .history_duotone_1,
                                            secondaryLayer: ProximityIcons
                                                .history_duotone_2,
                                            color: redSwatch.shade500),
                                        Text('Reservation',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 2),
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
                                        SizedBox(height: 3),
                                        Text(localizations.returnOrder,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 2),
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
                                        SizedBox(height: 3),
                                        Text(localizations.refund,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
                                      ]))),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    ordersService.getOrders("all", "Canceled");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrdersScreen(page: 4)));
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DuotoneIcon(
                                            size: 25,
                                            primaryLayer: ProximityIcons
                                                .rejected_duotone_1,
                                            secondaryLayer: ProximityIcons
                                                .rejected_duotone_2,
                                            color: redSwatch.shade500),
                                        Text(localizations.rejected,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    height: 0.9, fontSize: 7))
                                      ])))
                        ])))));
  }
}
