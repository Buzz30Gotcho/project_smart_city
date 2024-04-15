import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class ConfirmedTabView extends StatelessWidget {
  const ConfirmedTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    return Container();
    /* ordersService.getConfirmedOrders();

    return (ordersService.confirmedOrders == null)
        ? const Center(child: CircularProgressIndicator())
        : (ordersService.confirmedOrders!.isEmpty)
            ? const NoResults(
                icon: ProximityIcons.product,
                message: 'There are no Confirmed Orders.')
            : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: normal_100),
                itemCount: ordersService.confirmedOrders!.length,
                itemBuilder: (_, i) => OrderTile(
                  order: ordersService.confirmedOrders![i],
                  action: () {
                    ordersService.(
                        context, ordersService.confirmedOrders![i].id!);
                  },
                ),
              );*/
  }
}
