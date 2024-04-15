/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    ordersService.getReviewedOrders();

    return (ordersService.history == null)
        ? const Center(child: CircularProgressIndicator())
        : (ordersService.history!.isEmpty)
            ? const NoResults(
                icon: ProximityIcons.empty_illustration,
                message:
                    'Your Orders History is empty, consider Ordering products.')
            : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: normal_100),
                itemCount: ordersService.history!.length,
                itemBuilder: (_, i) => OrderTile(
                  order: ordersService.history![i],
                ),
              );
  }
}
*/